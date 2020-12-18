require 'bundler/setup'
require 'parslet'
require_relative 'tutor'

File.open('./test_input') do |f|
  @problems = f.readlines
end


@problems.each do |prob|
  pp prob
  t = Tutor.new
  begin
    t.parse(prob)
  rescue Parslet::ParseFailed => failure
    puts failure.parse_failure_cause.ascii_tree
  end
  # pp t
end


