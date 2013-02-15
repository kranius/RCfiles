require 'pdf-reader'

Dir["./**/*.pdf"].each do |pdf|
  File.open(pdf, "rb") do |io|
    puts "Writing " + pdf
    File.open(pdf.gsub("pdf", "txt"), "w") do |file|
      reader = PDF::Reader.new(pdf)
      reader.pages.each do |page|
        file.write(page.text)
      end
      file.close
    end
  end
end

