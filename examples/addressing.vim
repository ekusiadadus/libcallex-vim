so ../libcallex.vim

silent unlet! msvcrt
silent unlet! advapi32

let msvcrt = libcallex.load('msvcrt.dll')
let advapi32 = libcallex.load('advapi32.dll')

" make address of variable which is stored 256
let ptr = float2nr(eval(msvcrt.call('malloc', [4], 'number')))
call msvcrt.call('memset', [ptr, 0, 4], 'number')
call msvcrt.call('memset', [ptr+1, 1, 1], 'number')

let buf = repeat(' ', 256)
let args = [buf, ptr]
call advapi32.call('GetUserNameA', args, 'number')
let username = args[0]

call msvcrt.call('free', [ptr], 'number')

call libcallex.free(advapi32)
call libcallex.free(msvcrt)

echo username