local ffi = require 'ffi'

local ttypes = {
   {c='unsigned char', lua='Byte'},
   {c='char', lua='Char'},
   {c='short', lua='Short'},
   {c='int', lua='Int'},
   {c='long', lua='Long'},
   {c='float', lua='Float'},
   {c='double', lua='Double'}
}

local gcdef = [[

typedef struct
{
   CTYPE *data;
   long size;
   int refcount;
   char flag;
} THLTYPEStorage;

typedef struct
{
   long *size;
   long *stride;
   int nDimension;
   THLTYPEStorage *storage;
   long storageOffset;
   int refcount;
   char flag;
} THLTYPETensor;

]]

for _,ttype in ipairs(ttypes) do
   local cdef = gcdef:gsub('CTYPE', ttype.c):gsub('LTYPE', ttype.lua)
   ffi.cdef(cdef)

   local thf = ffi.typeof('TH' .. ttype.lua .. 'Tensor*')
   torch[ttype.lua .. 'Tensor'].data =
      function(self)
         local ptr = ffi.cast(thf, torch.pointer(self))
         return ptr.storage.data+ptr.storageOffset
      end

   local thf = ffi.typeof('TH' .. ttype.lua .. 'Storage*')
   torch[ttype.lua .. 'Storage'].data =
      function(self)
         local ptr = ffi.cast(thf, torch.pointer(self))
         return ptr.data
      end
end
