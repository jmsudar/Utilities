# Overview

Each of these files is descriptively named and contains a simple bash script that echos a command and pipes it to `pbcopy`. Originally, this was a textfile on my desktop containing commands I used frequently and didn't want to keep reminding myself of. To see what commands are available, use `ls`, and then run `./<filename>.sh` to copy the command to your clipboard. Then, paste, populate, and run.

All responsibility related to the use of these tools is assumed by anyone who uses them. This repo is shared under the GPL-3.0 license, indicating that the author does not assume any responsibility for how a given end user may use this material, or any consequences stemming from that use. Be responsible, be kind.

### YT-DLP

#### Prereq

```shell
brew install yt-dlp
```

#### yt-dlp_mp4FromChrome.sh

Downloads a .mp4 file from a target URL, using the cookies in chrome.

#### yt-dlp_MKVFromChrome.sh

Downloads a .mkv file from a target URL, using the cookies in chrome.

#### yt-dlp_MP3FromChrome.sh

Downloads a .mp3 file from a target URL, using the cookies in chrome.

### Archive Downloader

#### Prereq

[Link to Python project](https://github.com/john-corcoran/internetarchive-downloader)

```shell
$INTERNET_ARCHIVE_EMAIL
$INTERNET_ARCHIVE_PASS
```

#### archiveDownloader_downloadListOfURLs.sh

Uses `xargs` and `archive-org-downloader.py` to download each URL present in a file named `urls.txt` to `~/Downloads/`.

### CURL

#### Prereq

```shell
brew install curl
```

#### curl_hitEachInFile.sh

Uses `xargs` and `curl` to hit each URL present in a file named `urls.txt` to `~/Downloads/`. Technically doesn't need to be a download target, though that was the designed use case. Uses four degrees of parallelism.

### FFMPEG

#### Prereq

```shell
brew install ffmpeg
```

#### ffmpeg_convertMP4ToMKV.sh

Uses `ffmpeg`, `ls`, and `xargs` to convert every MP4 file in a directory from MP4 to MKV.

#### ffmpeg_convertMKVToMP4.sh

Uses `ffmpeg`, `ls`, and `xargs` to convert every MKV file in a directory from MKV to MP4.

### dotnet

#### Prereq

```shell
brew install --cask dotnet
```

The examples below assume you are using .NET 6.^, as at time of writing it is the most mature long-support .NET framework.

#### dotnet_runProject.sh

Uses `dotnet` to run a given .csproj file, assuming it has a main entrypoint.

#### dotnet_createSolutionFile.sh

Uses `dotnet` to create a new .sln file.

#### dotnet_createLibraryProject.sh

Uses `dotnet` to create a new library project file without a main entrypoint.

#### dotnet_createConsoleProject.sh

Uses `dotnet` to create a new console project with a main entrypoint.

#### dotnet_addProjectToSolution.sh

Uses `dotnet` to add a library or console project to a solution file.

#### dotnet_addNugetPackageToProject.sh

Uses `dotnet` to add a remote Nuget package to a project as a reference.

#### dotnet_updateNugetPackages.sh

Uses `dotnet` to update all installed Nuget packages.

#### dotnet_addLocalProjectAsReference.sh

Users `dotnet` to add a local project from the same monoprepo to a project as a reference.