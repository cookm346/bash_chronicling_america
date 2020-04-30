# Bash script to download and process Chronicling America newspaper corpus

This bash script will download all 2000+ tar.bz2 files by extracting out the necessary information from the .json file located at: https://chroniclingamerica.loc.gov/ocr.json The script will then untar and unzip the file, extract the .txt files, and organize the files into seperate directories.

warning: the entire corpus is well over 500GB of text files.

### Prerequisites

1. Download the download_files.sh script from this repository and move it to your working directory
2. Make a downloads and text directory with:
```bash
mkdir ./downloads
mkdir ./text
```
3. Download the jq library .json parser
```bash
suo apt-get install jq
```

### Running the script

To run the script, you can just run the following command:

```bash
bash download_files.sh
```

Alternatively, you can run the script by only calling the name of the file:

```bash
./download_files.sh
```

if you first change the excute permissions of the files using:

```bash
chmod u+x download_files.sh
```

<br>
<br>
<br>


