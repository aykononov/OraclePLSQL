Команда COMMIT
Фиксирует все изменения, внесенные в базу данных в ходе сеанса текущей транзакцией.
После выполнения этой команды изменения становятся видимыми для других сеансов
или пользователей. 
Синтаксис этой команды:
  COMMIT [WORK] [COMMENT текст];
Все команды в следующем фрагменте являются допустимыми:
  COMMIT;
  COMMIT WORK;
  COMMIT COMMENT 'maintaining account balance'.

Команда ROLLBACK
Она отменяет (полностью или частично) изменения, внесенные в базуданных в текущей транзакции.
Синтаксис команды ROLLBACK:
  ROLLBACK [WORK] [TO [SAVEPOINT] имя_точки_сохранения];
Все команды в следующем фрагменте являются допустимыми:
  ROLLBACK;
  ROLLBACK WORK;
  ROLLBACK TO begin_cleanup;

Команда SAVEPOINT
Устанавливает в транзакции именованный маркер, позволяющий в случае необходимости выполнить 
откат до отмеченной точки сохранения. При таком откате отменяются
все изменения и удаляются все блокировки после этой точки, но сохраняются изменения
и блокировки, предшествовавшие ей. 
Синтаксис команды:
  SAVEPOINT имя_точки_сохранения;
	
Команда SET TRANSACTION
Позволяет начать сеанс чтения или чтения-записи, установить уровень изоляции 
или связать текущую транзакцию с заданным сегментом отката. Эта команда должна быть 
первой командой SQL транзакции и дважды использоваться в ходе одной транзакции не может. 
У нее имеются четыре разновидности.

 SET TRANSACTION READ ONLY — определяет текущую транзакцию доступной «только для чтения». 
  В транзакциях этого типа всем запросам доступны лишь те изменения, которые были зафиксированы до начала транзакции. 
	Они применяются, в частности, в медленно формируемых отчетах со множеством запросов, благодаря чему в них
  часто используются строго согласованные данные.

 SET TRANSACTION READ WRITE — определяет текущую транзакцию как операцию чтения и записи данных в таблицу.

 SET TRANSACTION ISOLATION LEVEL SERIALIZABLE | READ COMMITTED — определяет способ выполнения транзакции, 
  модифицирующей базу данных. С ее помощью можно задать один из двух уровней изоляции транзакции: 
	SERIALIZABLE или READ COMMITTED.
  В первом случае команде DML, пытающейся модифицировать таблицу, которая уже изменена незафиксированной транзакцией, 
	будет отказано в этой операции. Для выполнения этой команды в инициализационном параметре COMPATIBLE базы
  данных должна быть задана версия 7.3.0 и выше.
	При установке уровня READ COMMITED команда DML, которой требуется доступ к строке, заблокированной другой транзакцией, 
	будет ждать снятия этой блокировки.
 
 SET TRANSACTION USE ROLLBACK SEGMENT имя_сегмента — назначает текущей транзакции заданный сегмент отката 
 и определяет ей доступ «только для чтения». Не может использоваться совместно с командой SET TRANSACTION READ ONLY.
 
Команда LOCK TABLE
Команда блокирует всю таблицу базы данных в указанном режиме. 
Блокировка запрещает или разрешает модификацию данных таблицы со стороны других транзакций на
то время, пока вы с ней работаете. 
Синтаксис команды:
  LOCK TABLE список_таблиц IN режим_блокировки MODE [NOWAIT];
	
Если команда содержит ключевое слово NOWAIT, база данных не ждет снятия блокировки
в том случае, если нужная таблица заблокирована другим пользователем, и выдает сообщение об ошибке. 
Если ключевое слово NOWAIT не указано, Oracle ждет освобождения таблицы в течение неограниченно долгого времени. 
Блокировка таблицы не мешает другим пользователям считывать из нее данные.
