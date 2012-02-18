def run(cmd, msg = nil)
  puts "=== %s" % msg if msg
  puts "=== %s" % cmd
  system cmd
  puts "\n"
end

watch("spec/.*_spec\.rb") { |m| run("bundle exec rspec %s" % m[0]) }
watch("lib/schnitzelpress/(.*)\.rb") { |m| run("bundle exec rspec spec/%s_spec.rb" % m[1]) }
watch('^spec/(spec_helper|factories)\.rb') { |f| run "bundle exec rake spec", "%s.rb has been modified" % f }

# Ctrl-\
Signal.trap('QUIT')   { run("bundle exec rake spec") }
# Ctrl-C
Signal.trap('INT')    { abort("\nQuitting.") }
