import csv

source_filename = input("Source filename: ")
source_col = input("Source column: ")
data_filename = input("Data filename: ")
index = data_filename.rfind('.')
outfile_name = f'{data_filename[:index]}_output{data_filename[index:]}'
target_col = input("Data column: ")
margin = float(input("PPM %: ")) / 100.0

try:
    with open(source_filename, encoding="utf8", newline='') as source, open(data_filename, encoding="utf8", newline='') as data, open(outfile_name, encoding="utf8", mode='w', newline='') as outfile:
        source_reader = csv.DictReader(source)
        data_reader = csv.DictReader(data)
        fields = data_reader.fieldnames
        data_list = list(data_reader)
        writer = csv.DictWriter(outfile, fieldnames=fields)
        writer.writeheader()
        for src_row in source_reader:
            writer.writerow({fields[0]: src_row[source_col]})
            for dat_row in data_list:
                try:
                    source = float(src_row[source_col])
                    data = float(dat_row[target_col])
                    if abs((data - source) / source) <= margin:
                        print(abs((data - source) / source))
                        writer.writerow(dat_row)
                except ValueError:
                    pass
except PermissionError:
    print("Could not open file")
