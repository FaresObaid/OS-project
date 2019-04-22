disk load was not working because we was loading sectors that doesn't exist
so after making it 2 it worked

the first sector has 0xdead and the second has 0xface

take care of segment registers when loading from disk
the issue is still there but on some computers it will work
