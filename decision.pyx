import re


# This function filters the reads based on the multimap option and decides whether or not to print
def decision(output, char *RefSpecies ,char *Same_method ,char *Dif_method, int maxLocs):
	cdef int ToBePrinted = 0
	cdef char* species = ""
	for species in output:
		if species == RefSpecies:
			#output_sorted = sorted(output[species], reverse = True) #Sort dictionary to test pickTop for duplicate top read
			if re.match(Same_method ,'unique'):
				if len(output[species]) == 1:
					ToBePrinted += 1
			elif re.match(Same_method ,'pickTop'):
				if len(set(output[species]) )< maxLocs:
					if len(output[species]) > 1 and len(set(output[species])) == 1: #Make sure length is greater than 1 and if IDs aren't duplicated in sam file
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
					if len(output[species]) > 1 and len(set(output[species])) == 1: #Make sure length is greater than 1 and if IDs aren't duplicated in sam file
						ToBePrinted += 1
					else: #If length is 1, this is basically unique option
						ToBePrinted += 1
			elif re.match(Dif_method ,'duplicated'):
				if len(output[species]) > 1:
					ToBePrinted += 1
			elif re.match(Dif_method ,'multimap'):
				ToBePrinted += 1
	return(ToBePrinted)