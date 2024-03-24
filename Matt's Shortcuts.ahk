RAlt::Send {RAlt}
RAlt & 1::Send #{1}
RAlt & 2::Send #{2}
RAlt & 3::Send #{3}
RAlt & 4::Send #{4}
RAlt & 5::Send #{5}
RAlt & 6::Send #{6}
RAlt & 7::Send #{7}
RAlt & 8::Send #{8}
RAlt & 9::Send #{9}
RAlt & 0::Send #{0}
RAlt & `::Send #{sc29}

;swap caps and escape
$CapsLock::SendInput {Escape}
$Escape::SetCapsLockState Off

;// not sure if this is still useful or not?
;^Ins::
;{
;    Send ^c
;}

:*:ssf::
(
SELECT	*
FROM	`
)
