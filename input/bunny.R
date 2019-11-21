library(magick)
library(bunny)

x <- magick::image_read("input/pipe2.png")
y <- magick::image_read("input/replay.png")

x%>% magick::image_scale("200x200")
y%>% magick::image_scale("200x200")

hex_canvas <- image_canvas_hex(border_color="#0d4448", border_size = 2, fill_color = "#ffffff")
hex_border <- image_canvas_hexborder(border_size = 1)

img_hex <- hex_canvas %>%
  bunny::image_compose(y%>%magick::image_scale('1300x1300'),
                       gravity = "center", offset = '+0-50')%>%  
  magick::image_annotate("%>%", size=250, 
                         weight = 700,
                         gravity = "center", 
                         location = '-300+100',
                         degrees = 350,
                         font = "Aller")%>%
  bunny::image_compose(hex_border, gravity = "center", operator = "Over")%>%
  magick::image_scale("200x200")

img_hex%>%
  magick::image_scale("200x200") %>%
  magick::image_write(here::here("input", "logo.png"), density = 600)

img_hex%>%
  magick::image_scale("1200x1200") %>%
  magick::image_write(here::here("input", "hex.png"), density = 600)


img_hex_gh <- img_hex %>%
  image_scale("400x400")

gh_logo <- bunny::github %>%
  image_scale("50x50")

gh <- image_canvas_ghcard("#ffffff") %>%
  image_compose(img_hex_gh, gravity = "East", offset = "+50+0") %>%
  image_annotate("Ripe: Rerun Pipes", gravity = "West", location = "+50-30",
                 color="#0d4448", size=60, font="Aller", weight = 700) %>%
  image_compose(gh_logo, gravity="West", offset = "+50+40") %>%
  image_annotate("yonicd/ripe", gravity="West", location="+110+45",
                 size=50, font="Ubuntu Mono") %>%
  image_border_ghcard("#ede6f2")

gh %>%
  image_write(here::here("input", "ripe_ghcard.png"))
