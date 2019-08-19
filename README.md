"# Court-Data-Base" 

 
תיאור מילולי:
בפרויקט זה נעסוק במיפוי מערכת בית משפט. 
המערכת שומרת פרטים של 3 סוגי אנשים היורשים מטיפוס בסיסי Person (אדם), המכיל את הפרטים הבאים : ת"ז, שם פרטי ,שם משפחה ,תאריך לידה , כתובת: שם הרחוב, מס' בית, עיר.
עבור שופטים (Judge) המערכת שומרת גם את תאריך התחלת העסקתם ע"מ לחשב את שנות הותק שלהם שקובעות את דרגת השופט. עבור עורכי דין (Lawyer) המערכת שומרת בנוסף את תאריך תחילת העסקתם וכן את תחום התמחותם: דיני עבודה, משפט פלילי, דינים מיסים, דיני משפחה, דיני מסחר.
עבור נאשמים  (Defendant) המערכת מוסיפה את מס' ההרשעות הקודמות שצבר.
כל שופט משויך לבית משפט אחד בלבד. עבור בית המשפט נשמרים: מס' זיהוי, סוג בית המשפט- השלום, מחוזי או עליון , וכן המחוז אליו משתייך.
כל תיק משפטי (Court_Case) מורכב ממס' זיהוי, תאריך פתיחת התיק , תאריך סגירת התיק , פסק הדין : זיכוי (True) או הרשעה (False) וכן סוג התיק : פלילי , תיק אימוץ , מסחרי , משפחתי.
בעקבות כל תיק משפטי ניתן להגיש ערעור(Appeal) על פסק הדין שפרטיו הם: מס' זיהוי,
תאריך ההגשה ופסק הדין :זיכוי (True) או הרשעה (False).
הערעור תלוי בתיק המשפטי  (ישות חלשה) וכן ניתן להגיש מס' ערעורים עבור תיק אחד.
בכל תיק משפטי משתתפים עורך דין אחד נאשם אחד ומס' שופטים.








 ERD-DIAGRAM: 
DSD:
 
טבלאות:
ישויות:
     Person:
ת"ז	integer	Id (primary key)
שם פרטי	Text	FirstName
שם משפחה	Text	LastName
תאריך לידה	Date	BirthDate
עיר	Text	City
רחוב	Text	Street
מס' בית	integer	Num
     








ת"ז	integer	Id (foreign key from person(Id)) , (primary key)
תאריך תחילת העסקה	Date	StartDate
תחום התמחות: דיני עבודה (labor), פלילים (criminal), דיני מיסים (tax), דיני משפחה (family) דיני מסחר (commercial)	Enum	Specialization
   Lawyer





ת"ז	integer	Id (foreign key from person(Id)) , (primary key)
תאריך תחילת העסקה	Date	StartDate
   Judge:


Defendant:
ת"ז	integer	Id (foreign key from person(Id)) , (primary key)
 מס' הרשעות קודמות	integer	NumPriors


 Court:
מס' זיהוי	integer	Id  (primary key)
מחוז	Text	Region
 סוג ביהמ"ש: מחוזי (district),השלום (magistrate),העליון (supereme). 	enum	Court_type




Court_case:
מס' זיהוי התיק	integer	caseId  (primary key)
סוג התיק: פלילי (criminal), אימוץ (adoption), מסחרי (commercial), משפחה (family).	enum	Case_type
תאריך פתיחת התיק	Date	OpenDate
תאריך סגירת התיק	Date	CloseDate
פסק הדין : זיכוי או הרשעה	Boolean	Verdict


Appeal:  (weak entity)
מס' זיהוי ערעור  	integer	AppId  (primary key)
מס' זיהוי תיק  	integer	CaseId  (foreign key from Court_case(CaseId))
תאריך הגשת הערעור	Date	 FillingDate
פסק הדין : זיכוי או הרשעה	Boolean	Verdict

קשרים:
•	JudgeOf – קשר  בין שופט (judge) לבית משפט (Court).                                                 זהו קשר 1: M – לבית המשפט יש מס' שופטים אך כל שופט שייך לבית משפט אחד בלבד. לכן, לא נוצרת טבלה חדשה עבור הקשר אלא נוסף שדה בטבלת הJudge  שתפקידו מפתח זר לטבלת הCourt (Foreign key)  למפתח שלה – Id.
•	Persides  – קשר בין שופט   (Judge) ותיק משפטי (Court_case).
זהו קשר M:N – בתיק יכולים להיות מס' שופטים וכן שופט משתתף במס' תיקים. לקשר זה נוצרת טבלה חדשה אשר המפתח הראשי שלה (primary key) הוא שילוב של 2 המפתחות הראשיים של Judge ו-Court_case שמשמשים כמפתחות זרים(Foreign  key), כלומר יחד הם מפתח מורכב.
•	LawerIn – קשר בין עורך דין (Lawyer) לתיק משפטי (Court_case).                                                    זהו קשר 1: M - עורך דין מתעסק במס' תיקים אך לכל תיק משפטי עורך דין אחד בלבד. לכן, לא נוצרת טבלה חדשה עבור הקשר אלא נוסף שדה בטבלת הCourt_case שתפקידו מפתח זר לטבלת הLawyer (Foreign key)  למפתח שלה – Id.
•	DefIn – קשר בין נאשם (Defendant) לתיק משפטי (Court_case).                                                      זהו קשר 1: M - נאשם מופיע במס' תיקים אך לכל תיק משפטי נאשם  אחד בלבד. לכן, לא נוצרת טבלה חדשה עבור הקשר אלא נוסף שדה בטבלת הCourt_case שתפקידו מפתח זר לטבלת הDefendant (Foreign key)  למפתח שלה – Id.
•	Preforms – קשר חלש בין ערעור (Appeal) לתיק משפטי (Court_case).                זהו קשרM :1 -  לכל ערעור תיק משפטי אחד בלבד אך לתיק משפטי יכולים להיות מס' ערעורים. מכיוון שזהו קשר חלש , לא נוצרת טבלה חדשה עבור הקשר אלא נוסף שדה בטבלת הAppeal  שתפקידו מפתח זר לטבלת ה    Court_case (Foreign key)  למפתח שלה – CaseId.










CREATE TABLE:


CREATE TABLE PERSON (
    P_Id           NUMBER(10) NOT NULL,
    First_Name     VARCHAR2(10) NOT NULL,
    Last_Name      VARCHAR2(10) NOT NULL,
    BirthDate      DATE NOT NULL,
    City           VARCHAR2(10) NOT NULL,
    Street         VARCHAR2(10) NOT NULL,
    H_Num          NUMBER NOT NULL,
CONSTRAINT pk_PERSON PRIMARY KEY (P_Id));


CREATE TABLE COUrt (
    C_id           NUMBER(10) NOT NULL,
    C_Region       VARCHAR2(10) NOT NULL,
    Court_type     VARCHAR2(10) NOT NULL,
CONSTRAINT pk_COURT PRIMARY KEY (C_id));


CREATE TABLE DEFENDANT (
    P_Id           NUMBER(10) NOT NULL,
    NumPriors      NUMBER(10) NOT NULL,
CONSTRAINT pk_DEFENDANT PRIMARY KEY (P_Id),
CONSTRAINT fk_DEFENDANT FOREIGN KEY (P_Id)
    REFERENCES PERSON (P_Id));


CREATE TABLE LAWYER (
    P_Id           NUMBER(10) NOT NULL,
    StartDate      DATE NOT NULL,
    Specialization VARCHAR2(10) NOT NULL,
CONSTRAINT pk_LAWYER PRIMARY KEY (P_Id),
CONSTRAINT fk_LAWYER FOREIGN KEY (P_Id)
    REFERENCES PERSON (P_Id));


CREATE TABLE JUDGE (
    P_Id           NUMBER(10) NOT NULL,
    StartDate      DATE NOT NULL,
    C_id           NUMBER(10) NOT NULL,
CONSTRAINT pk_JUDGE PRIMARY KEY (P_Id),
CONSTRAINT fk_JUDGE2 FOREIGN KEY (P_Id)
    REFERENCES PERSON (P_Id),
CONSTRAINT fk_JUDGE FOREIGN KEY (C_id)
    REFERENCES COURT (C_id)
    ON DELETE CASCADE);


CREATE TABLE COURT_CASE (
    Case_Id        NUMBER(10) NOT NULL,
    Case_type      VARCHAR2(10) NOT NULL,
    OpenDate       DATE NOT NULL,
    CloseDate      DATE NOT NULL,
    Verdict        CHAR(1) NOT NULL,
    L_Id           NUMBER(10) NOT NULL,
    D_id           NUMBER(10) NOT NULL,
    P_Id           NUMBER(10),
    P_Id1          NUMBER(10),
CONSTRAINT pk_COURT_CASE PRIMARY KEY (Case_Id),
CONSTRAINT fk_COURT_CASE FOREIGN KEY (P_Id)
    REFERENCES LAWYER (P_Id),
CONSTRAINT fk_COURT_CASE2 FOREIGN KEY (P_Id1)
    REFERENCES DEFENDANT (P_Id));


CREATE TABLE APPEAL (
    App_Id         NUMBER(38) NOT NULL,
    Case_Id        NUMBER(10) NOT NULL,
    FilingDate     DATE NOT NULL,
    Verdict        CHAR(1) NOT NULL,
CONSTRAINT pk_APPEAL PRIMARY KEY (App_Id,Case_Id),
CONSTRAINT fk_APPEAL FOREIGN KEY (Case_Id)
    REFERENCES COURT_CASE (Case_Id)
    ON DELETE CASCADE);



CREATE TABLE PERSIDES (
    P_Id           NUMBER(10) NOT NULL,
    Case_Id        NUMBER(10) NOT NULL,
    J_Id           NUMBER(10) NOT NULL,
CONSTRAINT pk_PERSIDES PRIMARY KEY (P_Id,Case_Id,J_Id),
CONSTRAINT fk_PERSIDES FOREIGN KEY (P_Id)
    REFERENCES JUDGE (P_Id)
    ON DELETE CASCADE,
CONSTRAINT fk_PERSIDES2 FOREIGN KEY (Case_Id)
    REFERENCES COURT_CASE (Case_Id));













INSERT:

INSERT INTO PERSON VALUES(11,'Dina','Levi',to_date('1961/08/25','yyyy/mm/dd'),'Haifa','Herzel',87) ;
INSERT INTO PERSON VALUES(12,'Sara','Shalom',to_date('1957/03/17','yyyy/mm/dd'),'Netanya','Hshomer',15) ;
INSERT INTO PERSON VALUES(13,'Baruch','Lev',to_date('1966/11/28','yyyy/mm/dd'),'Jerusalem','devash',30) ;
INSERT INTO PERSON VALUES(14,'Chaim','Rivlin',to_date('1970/04/06','yyyy/mm/dd'),'Jerusalem','pumbedita',6) ;
INSERT INTO PERSON VALUES(15,'Dan','Holander',to_date('1972/12/22','yyyy/mm/dd'),'Tel Aviv','dizingof',129) ;
INSERT INTO PERSON VALUES(16,'Yaron','Green',to_date('1989/02/09','yyyy/mm/dd'),'Tel Aviv','Hanevim',25) ;
INSERT INTO PERSON VALUES(17,'Bina','Nisan',to_date('1990/07/18','yyyy/mm/dd'),'Ramat Gan','Hgilgal',13) ;
INSERT INTO PERSON VALUES(18,'Moshe','Holander',to_date('1972/12/22','yyyy/mm/dd'),'Arad','Sharet',66) ;
INSERT INTO PERSON VALUES(19,'Shimon','BenDavid',to_date('1989/05/20','yyyy/mm/dd'),'Zfat','Bar Yochay',5) ;
INSERT INTO PERSON VALUES(20,'Ronit','Yizchak',to_date('1993/01/18','yyyy/mm/dd'),'Tverya','Rabi Akiva',83) ;
INSERT INTO PERSON VALUES(1752,'CHAVA','POLSKI',to_date('1995/11/21','yyyy/mm/dd'),'Haifa','Herzel',21) ;



INSERT INTO COURT VALUES(1,'Jerusalem','supereme') ;
INSERT INTO COURT VALUES(2,'Jerusalem','district') ;
INSERT INTO COURT VALUES(3,'South','district') ;
INSERT INTO COURT VALUES(4,'South','magistrate') ;
INSERT INTO COURT VALUES(5,'North','magistrate') ;
INSERT INTO COURT VALUES(6,'North','district') ;
INSERT INTO COURT VALUES(7,'Tel Aviv','district') ;
  



INSERT INTO JUDGE VALUES(11,TO_DATE('1999/08/26','yyyy/mm/dd'),1);
INSERT INTO JUDGE VALUES(17,TO_DATE('2000/08/19','yyyy/mm/dd'),3);
INSERT INTO JUDGE VALUES(15,TO_DATE('2001/10/10','yyyy/mm/dd'),5);

INSERT INTO PERSIDES VALUES(11,1,10);
INSERT INTO PERSIDES VALUES17,1,20));
INSERT INTO PERSIDES VALUES(17,2,30);
INSERT INTO PERSIDES VALUES15,2,40));





















































הכנסת נתונים באמצעות DATA GENERATOR:
הכנסה לטבלת PERSON:
Defenition:






Result:  



 
בס"ד
הכנסה לטבלת LAWYER:
Definition:
 
Result: 
 

הכנסה לטבלת APPEAL:
Definition: 










Result:
  
בס"ד
הכנסת נתונים לטבלאות באמצעות TEXT IMPORTER :
הכנסה לטבלת הcourt case :



  

הכנסה לטבלת הDEFENDANT:
 


 
בס"ד
הכנסה לטבלת הlawyer:
 


 
גיבוי
בשיטת הOracle Export: 

 
DROP TABLE

DROP TABLE APPEAL;
DROP TABLE PERSIDES;
DROP TABLE COURT_CASE;
DROP TABLE JUDGE;
DROP TABLE COURT;
DROP TABLE LAWYER;
DROP TABLE DEFENDANT;
DROP TABLE PERSON;















שחזור:
בשיטת הOracle Export:c8,

 


 

 


  
שאילתות:
שאילתות select :
שאילתה 1:
1.בביהמ"ש העליון נוצר מחסור שופטים עקב יציאה לפנסיה של מס' שופטים ותקים . הוועדה למינוי שופטים מחפשת מועמדים בעלי ותק של 10 שנים לפחות ממחוזות ירושלים והצפון כדי למלא את התקנים.(השאילתה מחזירה את שם השופט, ת"ז, תאריך תחילת העסקה ,ומחוז)
 יצירת טבלת עזר: (מכילה את שם השופט המלא, ת"ז ,תאריך תחילת העסקה ומחוז)

  
שאילתה 2:
הארכיונים בבהמ"ש השלום בכל המחוזות עוברים סדור ועדכון מחדש .במסגרת התהליך את כל התיקים שנסגרו עד שנת 2000 ולנאשמים בהם לא נפתחו תיקים נוספים מאוחרים יותר – מוציאים מהמערכת ומעבירים לגנזך הלאומי.
השאילתה מחזירה את מספרי התיקים שמועברים לגנזך הלאומי.
ניצור טבלת עזר :( מכילה  מס' ת"ז  של השופטים בבימ"ש השלום ברחבי הארץ)









ניצור טבלת עזר נוספת : ( מכילה את פרטי התיקים של ביהמ"ש השלום)






 
השאילתה:
 
בסוף השאילתה מחקנו את טבלאות העזר: 
שאילתה 3: 
לרגל יום המשפחה מעוניינת הלשכה המרכזית לסטטיסטיקה לפרסם דו"ח לגבי מצב תיקי האימוץ במדינת ישראל. השאילתה מחזירה עבור כל שנה את מס' התיקים שנסגרו בשנה זו ואת מס' התיקים שנפתחו בשנה זו (שנה שבה לא נפתחו או נסגרו תיקים לא מופיעה בתוצאות השאילתה)
ניצור טבלת  עזר המכילה את השנה ומסי התיקים שנפתחו בה:




ניצור טבלת עזר נוספת המכילה את השנה ומסי התיקים שנסגרו בה:







ניצור טבלת עזר נוספת שמכילה את רשימת השנים בהן נפתחו או נסגרו תיקי אימוץ :






השאילתה:












התוצאות:




בסוף השאילתה מחקנו את טבלאות העזר:



שאילתה 4:
עקב פרסומים בעיתונות הטוענים שמסי התיקים הפליליים הגבוה ביותר בארץ הוא במחוז חיפה ,מעוניינת עיריית חיפה בדו"ח נתונים מדויק שיסיר את החרפה מעל המחוז וימפה את מס' התיקים הפליליים במחוזות השונים.                                                                                                 השאילתה תחזיר לכל מחוז – את שמו ומס' התיקים הפליליים שנפתחו בו בשנת 2015.
השאילתה:






התוצאות:








שאילתה 5:
מערכת ביהמ"ש מעוניינת לעודד את השופטים בסגירת תיקים עקב העומס הרב במערכת ולכן הוכרזה  תחרות כך שהשופט\ים  שסגר\ו את התיקים במשך החודש הנוכחי יזכה \ו בפרס יוקרתי (נכון לחודש מאי 2017) .                                                                                                                      השאילתה תחזיר את פרטי השופט: שם מלא , ת"ז ,מס' תיקים שסגר , פרטי בימ"ש : מחוז, סוג.
 
שאילתה 6:
6. מנכ"ל חברת הביטוח "בטוחים בע"מ" בעל ת"ז 84001 חשוד במעילה כספית חמורה, במסגרת החקירות הנערכות נגדו  האגף להונאה במשטרת ישראל מעוניין לבדוק האם  הינו בעל תיקים  קודמים שהסתיימו בהרשעה .                                                                                                                     במקרה וישנו\ם תיק\ים כנ"ל השאילתה תחזיר את מס' התיק , סוג התיק ותאריך סגירה. 
השאילתה:  
שאילתה 7:
ע"מ להגיש מועמדות לתפקיד ראש עיר/מועצה בישראל  יש לעמוד בקריטריונים של ועדת הבחירות : המועמד צריך להיות בעל עבר נקי של 7 שנים ללא תיקים משפטיים מכל סוג שהוא, וכן ללא תיקים פליליים כלל.
ועדת הבחירות מעוניינת לקבל ממערכת ביהמ"ש בישראל את רשימת האנשים במערכת שאינם בקריטריונים לצורך השוואה עם רשימת המועמדים לבחירות הנוכחיות.
השאילתה:





התוצאות:









שאילתה 8:
עקב מס' הרב של הסטודנטים למשפטים והביקוש הגובר ללימודים אלו, כדי למנוע אינפלציה של עורכי דין בשוק, מעוניינת לשכת עורכי הדין לבדוק מהו תחום ההתמחות הנפוץ ביותר כרגע ע"מ להגביל את מסי המתמחים בו – השאילתה תחזיר את  שם תחום ומס' עורכי דין  העוסקים בו כיום.


השאילתה:
 














עדכונים:

עדכון 1:
נשיא המדינה הנוכחי מסיים את תקופת כהונתו , ובמסגרת הזכות השמורה לו להענקת חנינה החליט לזכות את הנאשמים בעלי תיקים פליליים שעברם המשפטי  נקי.
השאילתה:


לפני העדכון:











עדכון 2:
בעקבות מחסור חמור בשופטים  בביהמ"ש העליון , הוחלט באופן חד פעמי ששופטים מבהמ"ש המחוזי ירושלים שלהם יותר מ15 שנות ותק יהפכו לשופטי ביהמ"ש העליון.
השאילתה:

לפני העדכון :




















מחיקות :
מחיקה 1:

הכנסת חוקקה חוק חדש המגביל את מס' הערעורים שניתן להגיש על כל תיק משפטי ל2 בלבד. בעקבות זאת הוחלט למחוק אוטומטית את כל הערעורים שהוגשו החל מ01/01/2010 ואינם הראשונים או השניים עבור התיק המדובר.
השאילתה:  
לפני המחיקה:

 
אחרי המחיקה:
















מחיקה 2:
וירוס זדוני הוחדר למערכת הממוחשבת הארצית  של ביהמ"ש וע"מ לשבש את פעולת המערכת 'השתיל' נתונים פיקטיביים- תיקים שנפתחו על שמות עורכי דין ושופטים. יחידת הסייבר של משרד המשפטים מנסה בעבודה מאומצת למחוק את כל הנתונים הזדוניים.
מחיקה מטבלת :presides








לפני המחיקה:


 

 
מחיקת מטבלת defendant: 
 
מחיקת מטבלת court_case:
 
אינדקסים:
אינדקס 1:

אנשים (שופטים, עורכי דין ונאשמים)  שהאות שניה בשם משפחה הינו e:
לפני הוספת האינדקס
   
האינדקס:
  

לאחר הוספת האינדקס
 
אינדקס 2:

בתי משפט בירושלים:
לפני הוספת האינדקס:
                                                                      

האינדקס:                                                                  לאחר הוספת האינדקס:










אינדקס 3:
תיקים בדיני משפחה שנפתחו משנת 2000:
לפני הוספת האינדקס:
 
האינדקס:
 
לאחר הוספת האינדקס: 
 
rollback commit:

הכנסנו נתונים לטבלת court:
 
ואז עשינו commit:
 
ולאחר מכאן סגרנו את הsql  ושפתחנו הנתון החדש נשמר:
 
המסקנה: שה-  commitשומר את השינויים (הכנסה, מחיקה, עדכון)  שנעשו מפני ה - rollback
הכנסנו נתון נוסף לטבלת court:
 
 
ואז עשינו rollback:
 

ולאחר מכאן הנתון הנ"ל נמחק:
 
המסקנה: שה-rollback  מוחק את השינויים (הכנסה, מחיקה, עדכון)  שנעשו עד ל commit האחרון 
הרשאות
הרשאה 1:
הרשאה לcadler  לשלוף להוסיף, לעדכן, למחוק



הרשאה 2:
מתן זכות שליפה לכל המשתמשים עבור מידע על השופטים

אילוץ 1:
הגבלנו את הערך  בטבלת הlawyer  (עורכי הדין )בשדה הspecialization לאחד מהערכים : labor, criminal, commercial, family'
כאשר ניסינו להוסיף עוד עורך דין עם תחום התמחות שגוי- הופיעה הודעת שגיאה.
 


אילוץ 2:
הוספנו אילוץ לטבלת הcourt (בימ"ש) שמחייב את ייחודיות השילוב בין סוג ביהמ"ש והמחוז- כדי להבטיח שבכל מחוז יופיע בימ"ש אחד מכל סוג.court
 
כאשר ניסינו להוסיף שוב סוג בימ"ש במחוז שבו הוא כבר מופיע – התקבלה הודעת שגיאה 
 





אילוץ 3:
הוספנו עמודה לטבלת person בשם gender: 
 
 
הגבלנו את ערכיה ל'male '     (זכר ) או 'female' (נקבה).

ניסינו להוסיף שורה שבה הערך שגוי- וקיבלנו התרעה.




 
תצפיות
תצפית 1:
תצפית  על זמני פתיחה וסגירה של תיקים בדיני משפחה


View

  View הינה טבלה וירטואלית אשר לא באמת נמצאת בבסיס הנתונים אלא נועדה לייצוג (השקפה) בלבד ועל כן אין להסיר נתונים/טבלאות אשר היא מייצגת.
מבט 1:
לשכת ע"ד מעויינת לשמור באופן מרוכז מידע עבור עו"ד הקיימים במערכת, ת.ז,שם, תחום התמחות,מס' תיקים ועיר.
create:
create view lawyer_view(l_id,first_name,last_name,num_cases,specialization,city)
as select p_id,
          first_name,
          last_name,
          count(p_id),
          specialization,
          city
from lawyer natural join person natural join (select l_id as p_id
from court_case)
group by p_id, first_name,last_name, specialization,city


התוצאה:









Select 1:
לשכת עורכי הדין מחפשת את עוה"ד החרוץ ביותר -בעל מס' התיקים הגבוה ביותר.

select * from lawyer_view
where num_cases >= all(select num_cases
                       from lawyer_view)

התוצאה:



Select 2:
דני כהן סגן ראש עיריית ירושלים מואשם במעילה חמורה ולכן מחפש עורך דין בתחום הפלילים ירושלים.

select * from lawyer_view
where specialization = 'criminal'
       and city = 'Jerusalem'
       
התוצאה








Update:

הוחלט לשנות את שמות  תחומי ההתמחות של עורכי הדין , ולכן ישונה תחום ההתמחות דיני עבודה למסחר.
update lawyer_view 
      set specialization = 'commercial'
      where specialization = 'labor'
 התוצאה:
אין אפשרות לעדכן .






insert into lawyer_view values('180001','Lynn','Buckingham',3,'family','Bruneck')
התוצאה:
אין אפשרות להוסיף.






ע"מ להקל על העומס במערכת הוחלט למחוק את כל עורכי הדין בתחום הפלילים שאינם מבוקשים- יש להם פחות מ4 תיקים.

delete from lawyer_view 
       where specialization = 'criminal'
       and num_cases < 4
התוצאה:
אין אפשרות למחוק




בס"ד
מבט 2:
יצרנו טבלת view שמכילה את פרטי השופטים באופן מרוכז, עבור כל שופט את שמו, ת.ז., מחוז,תאריך לידה וסוג בית משפט
הטבלה ממויינת לפי שמות פרטיים.
create:
create view  judge_view(j_id,first_name,last_name,court_region,court_type,birthdate)
as select p_id,
          first_name,
          last_name,
          c_region,
          court_type,
          birthdate
from court natural join judge natural join person 
order by first_name
התוצאה:



















Select 1:
הבחירות לביהמ"ש העליון קרבות ולכן עורכים רשימת מועמדים מקרב שופטי ביהמ"ש המחוזיים בצפון עפ"י סדר אלפבתי של שמות משפחה.

select * from judge_view
where court_type= 'district'
and court_region = 'North'
order by last_name
 התוצאה:





Select 2:
בעקבות סדר מחודש במערכת בתי משפט ממיינים את השופטים עפ"י סדר אלפבתי של שמות פרטיים – אנו מעוניינים בשופטים ששמם הפרטי מתחיל בB.
select * from judge_view
where first_name like 'B%'
התוצאה:










Delete:
בעקבות חוק חדש שחוקקה הכנסת מוצאים לפנסיה כל השופטים מעל גיל 75 ולכן הם נמחקים מהמערכת.

delete from judge_view where (CURRENT_DATE - birthdate) > 365*75 
התוצאה:
















Update:

עקב קשיים כלכליים הוחלט לצמצמם את מס' בתי המשפט במחוז הצפון ולכן הועברו כל שופטי בית המשפט המחוזי לבית המשפט השלום

update judge_view set court_type = 'magistrate'
where court_type = 'district' and court_region = 'north'
התוצאה:
אין אפשרות לעדכן.





insert:
insert into judge_view values('180001','Lynn','Buckingam','south','district',to_date('10/07/1987','dd/mm/yyyy'))
התוצאה:
אין אפשרות להוסיף.


