note
	description: "Summary description for {CHU_PIECE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class	CHU_PIECE

create

	make_fen

feature {NONE} -- Initialization

	make_fen (a_code: CHARACTER; a_promoted: BOOLEAN)
			-- Initialize from Forsyth-Edwards code
		do
			if a_promoted then
				forsyth := "+"
			else
				forsyth := ""
			end
			if a_code.is_lower then
				forsyth := forsyth + converted_code (a_code.as_upper)
			else
				forsyth := forsyth + converted_code (a_code.as_upper).as_lower
			end
		end

feature -- Access

	forsyth: STRING
			-- Notation in George Hodges modified Forsyth notation

	converted_code (a_code: CHARACTER): STRING
			-- George Hodges Forsyth equivalent to `a_code' in Forsyth-Edwards
		do
			if attached forsyth_codes [a_code] as l_code then
				Result := l_code
			else
				Result := a_code.out -- should be an integer
			end
		end

	forsyth_codes: HASH_TABLE [STRING, CHARACTER]
			-- Codes indexed by Forsyth-Edwards code
		once
			create Result.make (22)
			Result.put ("P", 'P')
			Result.put ("GB", 'I')
			Result.put ("L", 'L')
			Result.put ("C", 'C')
			Result.put ("FL", 'F')
			Result.put ("P", 'S')
			Result.put ("S", 'P')
			Result.put ("G", 'G')
			Result.put ("DE", 'E')
			Result.put ("K", 'K')
			Result.put ("RC", 'A')
			Result.put ("B", 'B')
			Result.put ("BT", 'T')
			Result.put ("PH", 'X')
			Result.put ("KY", 'O')
			Result.put ("SM", 'M')
			Result.put ("VM", 'V')
			Result.put ("R", 'R')
			Result.put ("DH", 'H')
			Result.put ("DK", 'D')
			Result.put ("FK", 'Q')
			Result.put ("LN", 'N')
		end
	
end
