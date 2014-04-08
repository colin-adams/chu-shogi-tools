note

	description : "[
                        Converts first Chu SHogi position found in 
                        a Forsyth-Edwards Notation file to a .fsy
                        (George Hodges modified Forsyth notation) file.
                       ]"

	date        : "$Date$"
	revision    : "$Revision$"

class	FEN2FSY

inherit

	ARGUMENTS

create

	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_in, l_out: PLAIN_TEXT_FILE
		do
			create board.make_filled (create {CHU_PIECE}.make_fen ('1', False), 12, 12)
			if argument_count /= 2 then
			   	usage
			else
				create l_in.make_open_read (argument (1))
				create l_out.make_open_write (argument (2))
				read_input (l_in)
				l_in.close
				write_output (l_out)
				l_out.close
			end
		end

feature {NONE} -- Implementation

	board: ARRAY2 [CHU_PIECE]
			-- Representation of the parsed position

	read_input (a_file: PLAIN_TEXT_FILE)
			-- Read and process FEN from `a_file'.
		require
			a_file_open_read: a_file.is_open_read
		do
			a_file.read_line
			parse (a_file.last_string.substring (1, a_file.last_string.index_of (' ', 2) - 1))
		end

	parse (a_fen: STRING)
			-- Parse `a_fen' as a FEN description.
		local
			l_rows: LIST [STRING]
			l_next_promoted: BOOLEAN
			l_piece: CHU_PIECE
			i, j, k: INTEGER
		do
			l_rows := a_fen.split ('/')
			if l_rows.count = 12 then
				across l_rows as i_row loop
					i := i + 1
					j := 0
					across i_row.item as i_char loop
						if i_char.item = '+' then
							l_next_promoted := True
						else
							if i_char.item.is_digit then
								from
									k := i_char.item.code - ('0').code
								until
									k = 0
								loop
									j := j + 1
									create l_piece.make_fen ('1', False)
									k := k - 1
								end
							else
								j := j + 1
								create l_piece.make_fen (i_char.item, l_next_promoted)
								board.put (l_piece, i, j)
							end
							l_next_promoted := False
						end
					end
				end
			end
		end

	write_output (a_file: PLAIN_TEXT_FILE)
			-- Write `board' as Forsyth to `a_file'.
		require
			a_file_open_write: a_file.is_open_write
		local
			i, j, l_spaces: INTEGER
			l_code: STRING
		do
			a_file.put_character ('/')
			from
				i := 1
			until
				i > 12
			loop
				from
					j := 1
					l_spaces := 0
				until
					j > 12
				loop
					l_code := board.item (i, j).forsyth
					if l_code.is_integer then
						-- must be "1"
						l_spaces := l_spaces + 1
					else
						if l_spaces > 0 then
							a_file.put_integer (l_spaces)
							a_file.put_character (',')
						end
						a_file.put_string (l_code)
						if j < 12 then
							a_file.put_character (',')
						end
						l_spaces := 0
					end
					j := j + 1
				end
				if l_spaces > 0 then
					a_file.put_integer (l_spaces)
				end
				a_file.put_character ('/')
				i := i + 1
			end
		end

	usage
			-- Print usage message.
		do
			print ("Usage: fen2fsy <input-file-name> <output-file-name>")
		end

end
