;; Bytes, Characters and Encodings

#|
The read-char and write-char operations always use a UTF-8 encoding. If you have a
text stream that uses a different encoding, or if you want to generate a text stream in a differ-
ent encoding, use reencode-input-port or reencode-output-port. The reencode-
input-port function converts an input stream from an encoding that you specify into a
UTF-8 stream; that way, read-char sees UTF-8 encodings, even though the original used a
different encoding. Beware, however, that read-byte also sees the re-encoded data, instead
of the original byte stream.
|#
