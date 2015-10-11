def decision(output, RefSpecies ,Same_method ,Dif_method, maxLocs):
	ToBePrinted = 0
	for species in output:
		if species == RefSpecies:
			output_sorted = sorted(output[species], reverse = True) #Sort dictionary to test pickTop for duplicate top read
			if re.match(Same_method ,'unique'):
				if len(output[species]) == 1:
					ToBePrinted += 1
			elif re.match(Same_method ,'pickTop'):
				if len(output[species]) < maxLocs:
					if len(output_sorted) > 1: #Make sure length is greater than 1
						if int(output_sorted[0][0]) != output_sorted[1][0]: #Asks the question if quality M values are the same for first 2 reads (sorted)
							ToBePrinted += 1
						else: #Make sure duplicate sam outputs are accounted for and pass pickTop filter
							for i in range(1, len(output_sorted)): #Loop through all read IDs to ask if the chromosome start position is the same
								if int(output_sorted[0][0]) - int(output_sorted[i][0]) == 0: #Only account if the read quality is the same
									start_pos = [output_sorted[0][1].split()[3]] #Initialize first chromosome start position
									start_pos.append(output_sorted[i][1].split()[3]) #Append other start positions with identical read quality
							if len(set(start_pos)) <= 1: #Only pass if all the chromosome start positions are identical
								ToBePrinted += 1
					else: #If length is 1, this is basically unique option
						ToBePrinted += 1
			elif re.match(Same_method ,'duplicated'):
				if len(output[species]) > 1:
					ToBePrinted += 1
			elif re.match(Same_method ,'multimap'):
				ToBePrinted += 1
		else:
			if re.match(Dif_method ,'unique'):
				if len(output[species]) == 1:
					ToBePrinted += 1
			elif re.match(Dif_method ,'pickTop'):
				if len(output[species]) < maxLocs:
					if len(output_sorted) > 1: #Make sure length is greater than 1
						if int(output_sorted[0][0]) != output_sorted[1][0]: #Asks the question if quality M values are the same for first 2 reads (sorted)
							ToBePrinted += 1
						else: #Make sure duplicate sam outputs are accounted for and pass pickTop filter
                                                        for i in range(1, len(output_sorted)): #Loop through all read IDs to ask if the chromosome start position is the same
                                                                if int(output_sorted[0][0]) - int(output_sorted[i][0]) == 0: #Only account if the read quality is the same
                                                                        start_pos = [output_sorted[0][1].split()[3]] #Initialize first chromosome start position
                                                                        start_pos.append(output_sorted[i][1].split()[3]) #Append other start positions with identical read quality
                                                        if len(set(start_pos)) <= 1: #Only pass if all the chromosome start positions are identical
                                                                ToBePrinted += 1
					else: #If length is 1, this is basically unique option
						ToBePrinted += 1
			elif re.match(Dif_method ,'duplicated'):
				if len(output[species]) > 1:
					ToBePrinted += 1
			elif re.match(Dif_method ,'multimap'):
				ToBePrinted += 1
	return(ToBePrinted)
