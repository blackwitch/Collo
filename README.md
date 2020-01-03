# Collocō

[README in Korean](README_KR.md)

## Collo is short for Collocō. 

This project can help you to collect distributed data into a repository easily even if the data is in anywhere with only simple settings.

Collo was small code and was made for migration from MSSQL to MySQL and Elasticsearch for building DW and Statistics system. And now, it has improved to import and export another repositories and has more functions.

You can get data you want if there is a way to search on a repository. And you can modify and save the data. For example, you can use SQL if your repository is MySQL or MSSQL.

The repositories you can import 

* MSSQL
* MySQL
* Elasticsearch
* Redis
* AWS S3
* File
* REST API

The repositories you can export

* MSSQL
* MySQL
* Elasticsearch
* Redis
* File System
* Console

Collo handles all of data with JSON format. So you can add or modify your data easily. See details as follow samples and [document](SETTING.md).

Also Collo provides a management tool that is a web page by port number 10531/tcp. See details as "Managment Tool" section.


## Usage

- Migration all or special data you want between another RDBMS
- Export all or special data you want in a file from RDBMS 
- Export all data in RDBMS from Redis, AWS S3 or files
- Writing post data by HTTP in a repository you want


## Run the first example

Please install [NodeJS](https://nodejs.org) and [npm](https://www.npmjs.com/get-npm) before running your first example.

The first example is a sample to read __/samples/line_formated_sample.log__ file (This file is kind of web log file.). And Next, it will write in a file (__/samples/today_file_yyyy-mm-dd.log__) and print in console.

Run as belows.
>  node collo.js

This is the result.

![test_result](/images/first-test-result.PNG)


## Folders and files 

<pre><code>
.
├── css                     # Css files for tool
├── docs                    # Documentation files
├── images                  # Image files
├── repo-jobs-samples       # samples for repo and job
├── src                     # Source files
├── tool                    # Tools and utilities
├── samples                 # Repo, Job and DB schema sample files for testing
└── README.md

./src
├── collo.js                # Main source file
├── jobs.json               # Jobs what you want to do
├── repos.json              # Repositories what you want to read/write
.
.
</code></pre>

The almost important functions are in __collo.js__ except some reusable funtions. 


## Structure of Repositories and jobs

This repo and job is for the first example.

### Structure for Collo's repository 

Let see "/src/repos.json" file.

<pre><code>
{
  "grok_file_repo": [{                              >> (1)
    "type": "file",
    "name": "grok_sample_file",
    "config": {
      "path": "../samples/line_formated_sample.log" 
    }
  }],
  "daily_file_sample": [{
    "type": "file",
    "name": "file_for_today",
    "config": {
      "path": "../samples/today_file_@__today.txt"  >> (2) 
    }
  }],
  "console" : [{                                    >> (3) 
    "type" : "console",
    "name" : "console for debug"
  }]
}
</code></pre>

(1) A Collo's repository has a name you made and one or multiple configurations for repositories. If you set multiple configurations in a Collo's repository, Collo do the job repeatably. You need to configure for each repository. Please refer to [this link](SETTING.md)

(2) "@__today" is a keyword for Collo. The keywords will help you easily with a variety of situations when building your data.

(3) You can print what you want on __console__. This "console" repository will be added automatically even you don't set it. Please Don't use the "console" for other use.

### Structure for Collo's job

Let see "/src/jobs.json" file.

<pre><code>
{
    "grok2file_console_sample" : {
        "schedule" : "*/2 * * * * *",
        "from" : "grok_file_repo",
        "get_query" : "grok { %{IP:ip} }",
        "to": ["daily_file_sample", "console"],
        "set_query": ["{'date': ? , 'ip' : ?}", "{\"ip\":?}"],
        "set_query_param": ["@__yesterday as datetime_mmddyyyy, @ip as string", "@ip as string"]
    }
}
</code></pre>

__schedule__ : It's kind of __cron__. This sample will run once every two seconds.

__from__ : A repository What you want to import. Use the name you set it on "repos.json".

__get_query__ : Write a query to get data from __from__.

(option)__get_query_param__ : Add some parameters for your __get_query__ if it need.

(option)__filter__ : Add some values in result data to get from __get_query__.

__to__ : A repository What you want to export. Use the name you set it on "repos.json".

__set_query__ :  Write a query to insert or uupdate data to __to__. 

(option)__set_query_param__ : Add some parameters for your __set_query__ if it need.

Please see details to [this link](SETTING.md)

### There is some more examples.

There is some more examples in /repo-jobs-samples. Move repos-xxx.json and jobs-xxx.json to /src/repos.json and /src/jobs.json. And next, run collo. And you can test other examples.

If you want to test on MSSQL or MySQL, make DB and tables with /samples/collo-mssql-sample-db.sql or collo-mysql-sample-db.sql before you test it.


### Cautions

Collo creates /src/savedata.json for recording of the job processing. If you want to initialize or handle it, you can delete or modify the file.


## Documents 

[Introduction](https://www.slideshare.net/winninghabit/collo-01-en)

[Redis to MySQL](https://www.slideshare.net/winninghabit/collo-02-en)


## License infomation

__Collo__ is distributed under the terms and conditions of the MIT license.
