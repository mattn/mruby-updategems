gitgem = []
MRuby.each_target do |t|
  gems.each do |g|
   if g.dir && FileTest.exist?("#{g.dir}/.git")
      gitgem << [g.name, File.expand_path(g.dir)]
    end
  end
end

desc "update all git based mrbgems"
task :updategems do
  gitgem.each do |g|
    puts "Updating gem: #{g[0]}"
    chdir g[1]
    branch = `git branch`.lines.select {|x| x =~ /^\*/}.first[2..-1]
    sh "git pull origin #{branch}"
    puts
  end
end
