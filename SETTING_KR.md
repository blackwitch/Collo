# SETTING

저장소 세팅을 위해 아래 npm projects를 참고하세요. Collo는 여러 저장소에 대한 연결을 위해 다른 npm project를 사용합니다.

아래는 Collo가 여러 저장소 연결을 위해 사용중인 다른 npm 프로젝트의 링크입니다.

[LINK for MSSQL](https://www.npmjs.com/package/mssql)

[LINK for MySQL](https://www.npmjs.com/package/mysql)

[LINK for REDIS](https://www.npmjs.com/package/redis)

[LINK for Elasticsearch](https://www.npmjs.com/package/elasticsearch)

[LINK for AWS S3](https://www.npmjs.com/package/aws-sdk)


## 예약 키워드

키워드들은 저장소의 이름 혹은 쿼리문의 파라미터를 위해 사용됩니다.


### 저장소 이름에 사용되는 키워드들

|keyword|type|desc|caution|
|---|---|---|---|
|@__today|datetime| [yyyy-mm-dd] 포멧 형태로 오늘 날짜값으로 대체됩니다.|-|
|@__today_number|int| [yyyymmdd] 포멧의 정수형 형태로 오늘 날짜값으로 대체됩니다.|-|
|@__yesterday|datetime| [yyyy-mm-dd] 포멧 형태로 어제 날짜값으로 대체됩니다.|-|
|@__yesterday_number|int| [yyyymmdd] 포멧의 정수형 형태로 어제 날짜값으로 대체됩니다.|-|


### 쿼리의 파라미터로 사용되는 키워드들

파라미터를 사용할 때 항상 자료형을 정의해줘야 합니다. ((ex) @__today as int / @__today as datetime) 


#### 날짜 관련 키워드들

|keyword|type|desc|caution|
|---|---|---|---|
|@__today|int| [yyyy-mm-dd] 포멧의 정수형 형태로 오늘 날짜값으로 대체됩니다.|-|
|@__today|datetime_mmddyyyy| [mm-dd-yyyy hh:MM:ss]포멧 형태로 오늘 날짜값으로 대체됩니다.|-|
|@__today|datetime_yyyymmdd| [yyyy-mm-dd hh:MM:ss]포멧 형태로 오늘 날짜값으로 대체됩니다.|-|
|@__today|date| [yyyy-mm-dd]포멧 형태로 오늘 날짜값으로 대체됩니다.|-|

더해서, 다른 날짜 관련 키워드들도 위와 같은 형태로 사용됩니다. __@__yesterday__, __@__tomorrow__, __@__daysago__, __@__weeksago__ and  __@__monthsago__ 와 같은 키워드들이 존재합니다.

예를 들면, "15@__daysago as date"를 사용하면 15일 일자의 값을 얻을 수 있습니다.


#### 순차 증가값 관련 키워드들

|keyword|type|desc|caution|
|---|---|---|---|
|@__lastNumber_xxx|int| "xxx"는 읽기 쿼리에서 사용한 어떤 컬럼의 이름을 의미합니다. 만약 순차적으로 증가하는 어떤 데이타를 읽기를 원할 때,( 예를 들자면, Oracle의 sequence 컬럼 혹은 MySQL의 auto_increment 컬럼과 같은 ..), 이 키워드를 사용할 수 있습니다.. Collo는 항상 마지막으로 읽은 이 컬럼의 값을 "savedata.json"파일에 저장합니다.|-|
|@__lastInstanceNumberByDay_xxx|int| 이 키워드는 @__lastNumber_xxx와 거의 유사합니다. 하지만 이값은 매일 0시에 0으로 초기화 됩니다. 매일 반복적으로 전체 데이터 혹은 특정 조건의 값을 읽을 때 유용합니다. ||

#### "get_query"를 통해 획득한 데이터 사용하기

"get_query"를 통해 획득한 결과값(이하 "결과값")들을 "set_query"를 이용해 원하는 저장소에 기록할 수 있습니다. 결과값은 json 형태로 획득되며, 키값에 @ 를 붙여 set_query의 인자값으로 사용할 수 있습니다.

예를들어 결과값이 [{ "id" : "AxdfdsX$AS", "name" : "peter"}, { "id" : "Ecxsdw$daDS", "name" : "peter"}] 이며, "set_query : insert into tableA (column_id, column_name) values (?, ?)"이라 설정 후, "set_query_param : '@id, @name'"으로 세팅하면 읽어들인 결과값의 id와 name을 tableA의 column_id에 @id(결과값 중 id를 키로하는 값)를, column_name에는 @name(결과값 중 name를 키로하는 값)을 삽입하게 된다.


#### 기타

|keyword|type|desc|caution|
|---|---|---|---|
|@__dbname|string| 이 키워드는 저장소의 이름으로 대체됩니다.||


## 저장소 설정 예

"/repo-jobs-samples" 폴더에 있는 다른 예제들을 참고하세요.

MSSQL을 예로 들어 보겠습니다.

<pre><code>
<b>"repo_name"</b> : {
  <b>"name"</b> : "sample_db_1",            // @__dbname 키워드는 이 값으로 대체됩니다.
  <b>"type"</b> : "mssql",
  <b>"config"</b> : {                       // 이 부분은 저장소의 종류에 따라 달라집니다. 보다 상세한 부분은 [LINK for MSSQL](https://www.npmjs.com/package/mssql)를 참고하세요.
    "user": "your accout for mssql",
    "password": "your password for mssql",
    "server": "ip address",
    "port": port_number,
    "database" : "Database name",
    "pool" : {                              //  pooling 설정입니다.
      "min": 1,
      "max": 2,
      "idleTimeoutMillis": 30000
    }
  }
}
</code></pre>


### 작업 설정 예

<pre><code>
<b>"jos_name"</b> : {
  <b>"schedule"</b> : "* * * * * *",                              // cron과 같은 포멧으로
  <b>"from"</b> : "repo_name you want to read",
  <b>"get_query"</b> : "SELECT TOP 10 index, name, address FROM usertable WITH(NOLOCK) WHERE index>? and login_date = ? ORDER BY index",
  <b>"get_query_param"</b> : "@__lastNumber_index, @__yesterday as datetime_mmddyyyy", // <b>"get_query"</b>의 "?" 개수만큼의 파라미터를 설정하세요.
    <b>"filter"</b> : {
      <b>"add_keyvalue"</b> : [{"world": "@__dbname as string"}]  //  get_query의 결과에 @__dbname값을 world라는 이름으로 삽입합니다.
    },
  <b>"to"</b> : 'repo_name you want to write',                    // 다른 MSSQL에 읽어온 데이타를 입력한다고 가정해 봅시다.
  <b>"set_query"</b> : 'INSERT INTO usertable_backup (today, dbname, index, name, address) values (?, ?, ?, ?, ?)',
  <b>"set_query_param"</b> : '@__today as datetime_yyyymmdd, @world as string, @index as int, @name as string, @address as string'
}
</code></pre>
