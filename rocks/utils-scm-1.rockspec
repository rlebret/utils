package = "utils"
version = "scm-1"

source = {
   url = "git://github.com/rlebret/utils",
   branch = "master",
}

description = {
   summary = "Declare pointer C to Storage & Tensor",
   detailed = [[
   ]],
   homepage= "https://github.com/rlebret/utils",
   license = "BSD"
}

dependencies = {
   "torch >= 7.0"
}

build = {
   type = "builtin",
   modules = {
      ["utils.init"] = "init.lua"
   }
}
