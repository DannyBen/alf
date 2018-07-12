# Stepdefs courtesy of Clicumber
# https://github.com/DannyBen/clicumber

# Hooks

# Undo the "change dir" step if needed
After do
  next unless $original_dir
  Dir.chdir $original_dir
  $original_dir = nil
end

## Given...dir

Given(/^I am in the "([^"]+)" (?:folder|dir|directory)$/) do |dir|
  $original_dir = Dir.pwd unless $original_dir
  Dir.chdir dir
end

Given(/^the (?:folder|dir|directory) "([^"]*)" (does not )?exists?$/) do |dir, negate|
  if negate
    FileUtils.rm_rf(dir) if Dir.exist? dir
  else
    Dir.mkdir(dir) unless Dir.exist? dir
  end
end

Given(/^the (?:folder|dir|directory) is (not )?empty$/) do |negate|
  if negate
    FileUtils.touch "file_zero" if Dir["*"].empty?
  else
    FileUtils.rm_f Dir["*"] unless Dir["*"].empty?
  end
end

Given(/^the (?:folder|dir|directory) "([^"]*)" is like "([^"]*)"$/) do |target, source|
  FileUtils.cp_r source, target
end

## Given...file

Given(/^the file "([^"]*)" (does not )?exists?$/) do |file, negate|
  if negate
    File.delete(file) if File.exist? file
  else
    File.write(file, 'stub') unless File.exist? file
  end
end

Given(/^the file "([^"]*)" (?:contains|has the content) "([^"]*)"$/) do |file, content|
  File.write(file, content)
end

Given(/^the file "([^"]*)" is like "([^"]*)"$/) do |target, source|
  FileUtils.cp source, target
end

## Given...environment

Given(/^the variable "([^"]*)" is (not )?"([^"]*)"$/) do |name, negate, value|
  if negate
    ENV[name] = "not_#{value}"
  else
    ENV[name] = value
  end
end

## Given...ran

Given(/^I have already ran "([^"]*)"$/) do |command|
  @stdout, @stderr, @status = Open3.capture3 command
end

## When...run

When(/^I run: (.+)$/) do |command|
  @stdout, @stderr, @status = Open3.capture3 command
end

When(/^I run "([^"]+)"$/) do |command|
  @stdout, @stderr, @status = Open3.capture3 command
end

## When...dir

When(/^I go into the "([^"]*)" (?:folder|dir|directory)$/) do |dir|
  $original_dir = Dir.pwd unless $original_dir
  Dir.chdir dir
end

## When...wait
When(/^I wait (?:for )?"([^"]*)" seconds?$/) do |seconds|
  sleep seconds.to_f
end

## When...save

When(/^I save the (error )?output to "([^"]*)"$/) do |stderr, file|
  stream = stderr ? @stderr : @stdout
  File.write file, stream
end

## Then...output

Then(/^the (error )?output should (not )?be like "([^"]*)"$/) do |stderr, negate, file|
  stream = stderr ? @stderr : @stdout
  if negate
    expect(stream).to_not eq File.read(file)
  else
    expect(stream).to eq File.read(file)
  end
end

Then(/^the (error )?output should (not )?resemble "([^"]*)"(?: by "(\d{1,2})%?")?$/) do |stderr, negate, file, percentage|
  stream = stderr ? @stderr : @stdout
  similarity = stream.similar File.read(file)
  percentage ||= 90
  if negate
    expect(similarity).to_not be >= percentage.to_f
  else
    expect(similarity).to be >= percentage.to_f
  end
end

Then(/^the (error )?output should (not )?match "([^"]*)"$/) do |stderr, negate, content|
  stream = stderr ? @stderr : @stdout
  if negate
    expect(stream).to_not match /#{content}/im
  else
    expect(stream).to match /#{content}/im 
  end
end

Then(/^the (error )?output should (not )?(?:contain|include|have|say|read) "([^"]*)"$/) do |stderr, negate, content|
  stream = stderr ? @stderr : @stdout
  if negate
    expect(stream).to_not include content
  else
    expect(stream).to include content
  end
end

Then(/^the (error )?output should (not )?(?:be|equal) "([^"]*)"$/) do |stderr, negate, content|
  stream = stderr ? @stderr : @stdout
  if negate
    expect(stream.strip).to_not eq content
  else
    expect(stream.strip).to eq content
  end
end

## Then...file

Then(/^the file "([^"]*)" should (not )?exist$/) do |file, negate|
  if negate
    expect(File).to_not exist(file)
  else
    expect(File).to exist(file)
  end
end

Then(/^the file "([^"]*)" should (not )?match "([^"]*)"$/) do |file, negate, content|
  if negate
    expect(File.read file).to_not match /#{content}/im
  else
    expect(File.read file).to match /#{content}/im
  end
end

Then(/^the file "([^"]*)" should (not )?(?:contain|include|have|say|read) "([^"]*)"$/) do |file, negate, content|
  if negate
    expect(File.read file).to_not include content
  else
    expect(File.read file).to include content
  end
end

Then(/^the file "([^"]*)" should (not )?(?:be|equal) "([^"]*)"$/) do |file, negate, content|
  if negate
    expect(File.read(file).strip).to_not eq content
  else
    expect(File.read(file).strip).to eq content
  end
end

Then(/^the file "([^"]*)" should (not )?be like "([^"]*)"$/) do |file1, negate, file2|
  if negate
    expect(File.read(file1).strip).to_not eq File.read(file2).strip
  else
    expect(File.read(file1).strip).to eq File.read(file2).strip
  end
end

## Then...dir

Then(/^the (?:folder|dir|directory) "([^"]*)" should (not )?exist$/) do |dir, negate|
  if negate
    expect(Dir).to_not exist(dir)
  else
    expect(Dir).to exist(dir)
  end
end

Then(/^the (?:folder|dir|directory) should (not )?be empty$/) do |negate|
  if negate
    expect(Dir['*']).to_not be_empty
  else
    expect(Dir['*']).to be_empty
  end
end

## Then...debug

Then(/^stop for debug$/) do
  byebug
end

## Then...exit code

Then(/^the (?:status|exit) code should (not )?be "([^"]+)"$/) do |negate, code|
  if negate
    expect(@status.exitstatus).to_not eq code.to_i
  else
    expect(@status.exitstatus).to eq code.to_i
  end
end

Then(/^the (?:status|exit) code should mean (success|failure)$/) do |type|
  if type == "failure"
    expect(@status.success?).to_not be true
  else
    expect(@status.success?).to be true
  end
end
