gitgem = []
MRuby.each_target do |t|
  gems.each do |g|
   if g.dir && FileTest.exist?("#{g.dir}/.git")
      gitgem << {:name => g.name, :dir => File.expand_path(g.dir)}
    end
  end
end

desc "update all git based mrbgems"
task :updategems do
  gitgem.each do |g|
    puts "Updating gem: #{g[:name]}"
    chdir g[:dir]
    branch = `git branch`.lines.select {|x| x =~ /^\*/}.first[2..-1]
    sh "git pull origin #{branch}"
    puts
  end
end
