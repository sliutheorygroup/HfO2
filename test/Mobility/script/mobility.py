######################μ=v/E####################
import math
import numpy as np

###calculate v ###
with open('HfO2-npt.MSD', 'r') as file:
    lines = file.readlines()

# last 1500 lines
fit_lines = lines[-1:]
result = []
time = []

# Iterate through the last 1500 lines and take the square root of columns 2-5
for line in fit_lines:
    columns = line.split()
    if len(columns) >= 5:
        msd_sqrt = [math.sqrt(float(x)) for x in columns[1:5]]
        result.append(msd_sqrt)
        time.append(float(columns[0]) * 0.001)

# Convert the result list to a NumPy array
result_array = np.array(result)
time_array = np.array(time)

# Fitting
slope, intercept = np.polyfit(time_array, result_array, 1)

# Write the slope to the file slope.dat
with open('slope-v.dat', 'w') as slope_file:
    for vvalue in slope:
        slope_file.write(f"{vvalue} ")

### Check electric field ###
with open('input.lammps', 'r') as file:
    for line in file:
        if 'variable VALUEZ  equal' in line:
            parts = line.split('equal')
            if len(parts) > 1:
                # Extract the Evalue
                Evalue = parts[1].strip().split()[0]
                break  # Stop iterating after finding it

### Calculate μ (mu) ###
mu = abs(slope*10000 / (float(Evalue)*1000000*100))

# Write μ to the mu.dat file
with open('mu.dat', 'w') as miu_file:
    for mu_value in mu:
        miu_file.write(f"{mu_value} ")
