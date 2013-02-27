Channel.delete_all
Settings.delete_all
Slide.delete_all

channel = Channel.create(name: "Default channel")
slide = UrlSlide.create(name: "Default slide")
channel.slides << slide
channel.set_as_default
