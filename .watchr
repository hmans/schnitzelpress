def run(cmd)
  puts cmd
  system cmd
  puts "\n"
end

watch("test/.*_test\.rb")        { |m| run("bundle exec ruby %s" % m[0]) }
watch("lib/schreihals/(.*)\.rb") { |m| run("bundle exec ruby test/%s_test.rb" % m[1]) }
watch('^test/test_helper\.rb')   { run "rake test" }

# Ctrl-\
Signal.trap('QUIT')   { run("rake test") }
# Ctrl-C
Signal.trap('INT')    { abort("\nQuitting.") }
