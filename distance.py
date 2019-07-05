# a function designed to eval the similarity

import csv

def distance(list1, list2, debug=False):
	"""
	(0) - length
	(1) - RMS
	(2) - WIDTH
	(3) - BPM
	(04-93) - FREQ VEC
	(94-193 ) - ENG VEC NORM
	(194-203) - ENG VEC SORT
	"""
	time_diff = abs(list1[0]-list2[0])
	rms_diff = abs(list1[1]-list2[1])
	width_diff = abs(list1[2]-list2[2])
	bpm_diff = abs(list1[3]-list2[3])

	if time_diff > 30:
		return -1
	elif rms_diff > 0.05:
		return -1
	elif width_diff > 0.1:
		return -1
	elif bpm_diff > 5:
		return -1

	freq_sim = l2_norm(list1[4:94], list2[4:94])
	energy_sim = l2_norm(list1[94:194], list2[94:194])
	energy_sort = l2_norm(list1[194:204], list2[194:204])

	score = 10*freq_sim + energy*20 + energy_sort*100
	return score

	if debug:
		print("Time Difference is: ", time_diff)
		print("RMS Difference is: ", rms_diff)
		print("Width Difference is: ", width_diff)
		print("BPM Difference is: ", bpm_diff)
		print("Freq similarity Difference is: ", freq_sim)
		print("Energy similarity Difference is: ", energy_sim)
		print("energy distribution Difference is: ", energy)


def l2_norm(list_a, list_b):
	if len(list_a) == len(list_b):
		d = 0
		for i in range(len(list_a)):
			d += (list_a[i] - list_b[i])**2
		return d
	else:
		return -1


if __name__ == "__main__":
	csvfile1 = "/Users/baboo/Desktop/tmp/mfm_vec/Ana Alcaide - Tishri.csv"
	csvfile2 = "/Users/baboo/Desktop/tmp/mfm_vec/Anita Ward - I'm Ready for Love.csv"

	with open(csvfile1) as file1:
		list1 = [float(i) for l in csv.reader(file1) for i in l]

	with open(csvfile2) as file2:
		list2 = [float(i) for l in csv.reader(file2) for i in l]

	distance = distance(list1, list2, debug=True)
	print(distance)

