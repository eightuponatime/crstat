lib LibC
  struct StatVfs
    f_bsize : ULong
    f_frsize : ULong
    f_blocks : ULong
    f_bfree : ULong
    f_bavail : ULong
    f_files : ULong
    f_ffree : ULong
    f_favail : ULong
    f_fsid : ULong
    f_flag : ULong
    f_namemax : ULong
  end

  fun statvfs(path : Char*, buf : StatVfs*) : Int
end
