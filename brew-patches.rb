ARGV.formulae.each do |f|
  patches = f.patches rescue next
  next if patches.empty?
  puts f.name
  patches = {:p1 => patches} unless patches.is_a? Hash
  f.patches.each_value do |urls|
    urls = [urls] unless urls.is_a? Array
    urls.each do |u|
      puts u
    end
  end
  puts
end
