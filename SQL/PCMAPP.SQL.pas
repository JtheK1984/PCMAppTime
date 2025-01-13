unit PCMAPP.SQL;

interface
var
  // Datenmodul
  {$Region Datenmodul}
  sSQL_CREATE_TABLE_SERVER: String;
  sSQL_CREATE_TABLE_Login: String;
  sSQL_CREATE_TABLE_Autologin: String;
  sSQL_CREATE_TABLE_LastBooking: String;
  sSQL_CREATE_TABLE_SynchBooking: String;
  sSQL_CREATE_TABLE_Buchungen: String;
  sSQL_CREATE_TABLE_Fehltag: String;
  sSQL_CREATE_TABLE_Fehltage: String;
  sSQL_CREATE_TABLE_Monatswerte: String;
  sSQL_CREATE_TABLE_Kontakte: String;
  {$EndRegion Datenmodul}
  // Data
  {$Region Data}
  sSQL_SELECT_USERVERSION_PRAGMASYSTEM: String;
  sSQL_UPDATE_USERVERSION_PRAGMASYSTEM: String;
  sSQL_UPDATE_WRITABLE_SCHEMA_PRAGMASYSTEM: String;
  sSQL_DELETE_ALL_TABLES_SYSTEM: String;
  {$EndRegion Data}
  // Server
  {$Region Server}
	sSQL_SELECT_All_Server: String;
  sSQL_SELECT_All_Server_WHERE_BEZEICHNUNG: String;
	sSQL_SELECT_All_Server_WHERE_ID: String;
  sSQL_SELECT_COUNT_Server: String;
  sSQL_SELECT_ID_Server: String;
	sSQL_UPDATE_All_Server_WHERE_ID: String;
	sSQL_INSERT_All_Server: String;
  sSQL_DELETE_All_Server: String;
  {$EndRegion Server}
  // Autologin
  {$Region Autologin}
  sSQL_SELECT_All_AUTOLOGIN: String;
  sSQL_SELECT_COUNT_AUTOLOGIN: String;
  sSQL_UPDATE_ALL_AUTOLOGIN: String;
  sSQL_UPDATE_Benutzer_AUTOLOGIN: String;
  sSQL_UPDATE_Desgin_AUTOLOGIN: String;
  sSQL_UPDATE_DesginAPP_AUTOLOGIN: String;
  sSQL_UPDATE_DesginWin_AUTOLOGIN: String;
  sSQL_UPDATE_DEVICEID_AUTOLOGIN: String;
  sSQL_UPDATE_DEVICETOKEN_AUTOLOGIN: String;
  sSQL_UPDATE_Passwort_AUTOLOGIN: String;
  sSQL_UPDATE_FingerAutologin_AUTOLOGIN: String;
  sSQL_UPDATE_LOCALACCOUNT_AUTOLOGIN: String;
  sSQL_UPDATE_LOG_AUTOLOGIN: String;
  sSQL_INSERT_All_AUTOLOGIN: String;
  sSQL_INSERT_All_AUTOLOGIN_Without_localaccount: String;
  {$EndRegion Autologin}
  // Login
  {$Region Login}
  sSQL_SELECT_ALL_Login_WHERE_Benutzer: String;
	sSQL_SELECT_ALL_Login_WHERE_Benutzer_IDServer: String;
	sSQL_SELECT_ALL_Login_WHERE_IDBenutzer_IDServer: String;
	sSQL_SELECT_COUNT_Login: String;
	sSQL_UPDATE_ALL_login: String;
	sSQL_UPDATE_FIRSTSTART_login: String;
	sSQL_INSERT_All_login: String;
  {$EndRegion Login}
  // Personal
  {$Region Personal}
  {$EndRegion Personal}
  // Personal
  {$Region Personal}
  {$EndRegion Personal}
  // Online
  {$Region Online}
  sSQL_SELECT_TEXT_LASTBOOKING: String;
  sSQL_UPDATE_TEXT_LASTBOOKING: String;
  {$EndRegion Online}
  // Buchungen
  {$Region Buchungen}
  {$EndRegion Buchungen}
  // Fehltage
  {$Region Fehltage}
  {$EndRegion Fehltage}
  // Monatswerte
  {$Region Monatswerte}
  {$EndRegion Monatswerte}
implementation
begin
 // Datamodul
  {$Region Datenmodul}
	sSQL_CREATE_TABLE_SERVER:=                			  'CREATE TABLE IF NOT EXISTS Server ' +
																		  							'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
																	  								'Bezeichnung NVARCHAR(200),' +
																  									'Hostname NVARCHAR(200),' +
																								  	'Port NVARCHAR(200));';
  sSQL_CREATE_TABLE_Login:=               		  	  'CREATE TABLE IF NOT EXISTS Login ' +
																						  			'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
																					  				'ID_MA_Stammdaten INTEGER,' +
																				  					'ID_Server INTEGER,' +
																			  						'Benutzername NVARCHAR(101),' +
																		  							'Passwort NVARCHAR(256),' +
																	  								'FirstStart Boolean);';
  sSQL_CREATE_TABLE_Autologin:=              			  'CREATE TABLE IF NOT EXISTS Auto_Login ' +
								  																	'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
							  																		'ID_MA_Stammdaten INTEGER,' +
						  																			'ID_Server INTEGER,' +
					  																				'Benutzername  NVARCHAR(101),' +
				  																					'Passwort NVARCHAR(256),' +
			  																						'Autologin LOGICAL,' +
		  																							'FingerAuthenticate Boolean,' +
	  																								'Design Integer,' +
  																									'Localaccount Boolean,' +
																									  'DesignWin Integer,' +
																								  	'DesignApp Integer,' +
																							  		'DeviceID NVARCHAR(255),' +
																						  			'DeviceToken NVARCHAR(255),' +
                                                    'Log Integer);';
  sSQL_CREATE_TABLE_LastBooking:= 			  	 			  'CREATE TABLE IF NOT EXISTS LastBooking ' +
																			  						'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
																		  							'Text NVARCHAR(101));';
  sSQL_CREATE_TABLE_SynchBooking:=    			 			  'CREATE TABLE IF NOT EXISTS SynchBooking ' +
		  																							'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
	  																								'Datum Date,' +
  																									'Zeit Time,' +
																								  	'Buchungsart INTEGER,' +
																							  		'Typ INTEGER);';
  sSQL_CREATE_TABLE_Buchungen:= 			  		  		  'CREATE TABLE IF NOT EXISTS buchungen ' +
																					  				'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
																				  					'Datum Date,' +
																			  						'Tag NVARCHAR(101),' +
																		  							'Kommen time,' +
																	  								'Gehen time,' +
																  									'Pause1Beginn time,' +
															  										'Pause1Ende time,' +
														  											'Pause2Beginn time,' +
													  												'Pause2Ende time,' +
												  													'Sollstunden time,' +
											  														'SollstundenI INTEGER,' +
										  															'Arbeitszeit time,' +
									  																'ArbeitszeitI INTEGER,' +
								  																	'Feiertag INTEGER,' +
							  																		'Fehltag NVARCHAR(3),' +
						  																			'Mehrarbeit NVARCHAR(6),' +
					  																				'MehrarbeitI INTEGER,' +
				  																					'PausenI INTEGER,' +
			  																						'FeiertagI INTEGER,' +
		  																							'Abgeschlossen INTEGER,' +
	  																								'Buchungsart INTEGER,' +
  																									'ID_Fehltage INTEGER);';
  sSQL_CREATE_TABLE_Fehltag:=    		    		  			'CREATE TABLE IF NOT EXISTS Fehltag ' +
																					  				'(ID INTEGER ,' +
																				  					'Kuerzel NVARCHAR(101),' +
																			  						'Beschreibung  NVARCHAR(101),' +
																		  							'Typ INTEGER,' +
																	  								'Faktor INTEGER,' +
																  									'Bezahlt Integer);';
  sSQL_CREATE_TABLE_Fehltage:=   					    			'CREATE TABLE IF NOT EXISTS Fehltage ' +
					  																				'(ID INTEGER,' +
				  																					'Von Date,' +
			  																						'Bis Date,' +
		  																							'Kuerzel NVARCHAR(101),' +
	  																								'Beschreibung  NVARCHAR(101),' +
  																			 			  		'Tage Double);';
  sSQL_CREATE_TABLE_Monatswerte:=    			      	  'CREATE TABLE IF NOT EXISTS Monatswerte  ' +
																					  				'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
																				  					'Monat INTEGER,' +
																			  						'Jahr INTEGER,' +
																		  							'ID_Benutzer INTEGER,' +
																	  								'Sollzeit INTEGER,' +
																  									'IStzeit INTEGER,' +
															  										'Mehrarbeit INTEGER,' +
														  											'aktuelleMehrarbeit INTEGER,' +
						  																			'Pausen INTEGER,' +
					  																				'Urlaub_bezahlt DOUBLE,' +
				  																					'Urlaub_unbezahlt DOUBLE,' +
			  																						'Krank_bezahlt DOUBLE,' +
		  																							'Krank_unbezahlt DOUBLE,' +
	  																								'Feiertag INTEGER,' +
  																									'Resturlaub DOUBLE);';
  sSQL_CREATE_TABLE_Kontakte:=  		  					    'CREATE TABLE IF NOT EXISTS Kontakte ' +
			  																						'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
		  																							'Anrede NVARCHAR(101),' +
	  																								'Vorname NVARCHAR(101),' +
  																									'Nachname NVARCHAR(101),' +
																									  'Strasse NVARCHAR(101),' +
																								  	'PLZ NVARCHAR(101), ' +
																							  		'Ort NVARCHAR(101),' +
																						  			'Telefon NVARCHAR(101),' +
																					  				'Handy NVARCHAR(101),' +
																				  					'Email NVARCHAR(101),' +
																			  						'Link NVARCHAR(101),' +
																		  							'Geburtsdatum Date,' +
																	  								'Geschlecht NVARCHAR(101),' +
																  									'Familienstand NVARCHAR(101),' +
															  										'Staatsangehoerigkeit NVARCHAR(101),' +
														  											'Konfession NVARCHAR(101), '+
													  												'Firma NVARCHAR(101),' +
												  													'StrasseFirma NVARCHAR(101),' +
											  														'PLZFirma NVARCHAR(101),' +
										  															'OrtFirma NVARCHAR(101),' +
									  																'TelefonFirma NVARCHAR(101),' +
								  																	'HandyFirma NVARCHAR(101),' +
							  																		'EmailFirma NVARCHAR(101),' +
						  																			'LinkFirma NVARCHAR(101),' +
					  																				'Bild Memo,' +
                                                    'Urlaub Double,' +
                                                    'Eintritt Date,' +
                                                    'OffsetResturlaub DOUBLE,' +
                                                    'OffsetResturlaubJahr INTEGER,' +
                                                    'Personalnummer INTEGER,' +
                                                    'Sollstunden time)';
  {$endRegion Datenmodul}
  // Data
  {$Region Data}
  sSQL_SELECT_USERVERSION_PRAGMASYSTEM:=            'PRAGMA user_Version';
  sSQL_UPDATE_USERVERSION_PRAGMASYSTEM:=            'PRAGMA user_version=';
  sSQL_UPDATE_WRITABLE_SCHEMA_PRAGMASYSTEM:=        'PRAGMA writable_schema = ';
  sSQL_DELETE_ALL_TABLES_SYSTEM:=                   'delete from sqlite_master where type = ''table''';
  {$EndRegion Data}
  // Server
  {$Region Server}
	sSQL_SELECT_All_Server:=  										  	'SELECT * FROM Server';
  sSQL_SELECT_All_Server_WHERE_BEZEICHNUNG:=  			'SELECT * FROM Server WHERE Bezeichnung = :Bezeichnung';
	sSQL_SELECT_All_Server_WHERE_ID:= 	  						'SELECT * FROM Server WHERE ID = :ID';
  sSQL_SELECT_COUNT_Server:= 			  	  						'Select Count(*) as Anzahl FROM Server';
  sSQL_SELECT_ID_Server:= 						  						'Select ID FROM Server';
	sSQL_UPDATE_All_Server_WHERE_ID:= 	  						'UPDATE Server SET Bezeichnung = :Bez, Hostname = :Host, Port = :Port WHERE ID = :ID';
	sSQL_INSERT_All_Server:= 												  'INSERT INTO Server (Bezeichnung, Hostname, Port) VALUES (:Bez, :Host, :Port)';
	sSQL_DELETE_All_Server:= 												  'DELETE FROM Server';
  {$EndRegion Server}
  // Autologin
  {$Region Autologin}
  sSQL_SELECT_All_AUTOLOGIN:= 									  	'SELECT * FROM Auto_login';
  sSQL_SELECT_COUNT_AUTOLOGIN:= 								  	'Select Count(*) as Anzahl From Auto_login';
  sSQL_UPDATE_ALL_AUTOLOGIN:=								  			'UPDATE Auto_login Set ID_MA_Stammdaten = 0, ID_Server = :ID_Server, Benutzername =  :Benutzername, Passwort = :Passwort, Autologin = :Autologin, Design = :Design, Localaccount = :Localaccount ';
  sSQL_UPDATE_Benutzer_AUTOLOGIN:= 					  			'Update Auto_Login Set Benutzername = :Benutzername';
  sSQL_UPDATE_Desgin_AUTOLOGIN := 					  			'Update Auto_Login Set Design = :Design';
  sSQL_UPDATE_DesginAPP_AUTOLOGIN := 		  					'Update Auto_Login Set DesignApp = :Design';
  sSQL_UPDATE_DesginWin_AUTOLOGIN := 		  					'Update Auto_Login Set DesignWin = :Design';
  sSQL_UPDATE_DEVICEID_AUTOLOGIN:= 			  					'Update Auto_Login Set DeviceID = :DeviceID';
  sSQL_UPDATE_DEVICETOKEN_AUTOLOGIN:= 	  					'Update Auto_Login Set DeviceToken = :DeviceToken';
  sSQL_UPDATE_Passwort_AUTOLOGIN:= 			  					'Update Auto_Login Set Passwort = :Passwort';
  sSQL_UPDATE_FingerAutologin_AUTOLOGIN:= 		 			'UPDATE Auto_Login SET FingerAuthenticate = :Finger,Autologin = :Autologin';
  sSQL_UPDATE_LOCALACCOUNT_AUTOLOGIN:= 	  					'UPDATE Auto_login SET Localaccount = :Localaccount ';
  sSQL_UPDATE_LOG_AUTOLOGIN:= 					  		      'UPDATE Auto_login SET Log = :Log ';
  sSQL_INSERT_All_Autologin:=						  					'INSERT INTO Auto_login (ID_MA_Stammdaten, ID_Server, Benutzername, Passwort, Autologin, Design, DesignApp,DesignWin,Localaccount) VALUES (0, :ID_Server, :Benutzername, :Passwort, :Autologin, :Design,:DesignApp,:DesignWin, :Localaccount)';
  sSQL_INSERT_All_AUTOLOGIN_WITHOUT_LOCALACCOUNT:=  'INSERT INTO Auto_Login (Log,ID_MA_Stammdaten, ID_Server, Benutzername, Passwort, Autologin, Design, DesignApp,DesignWin) VALUES (:Log,:ID, :ID_Server, :Benutzername, :Passwort, :Autologin, :Design,:DesignApp,:DesignWin)';
  {$EndRegion Autologin}
  // Login
  {$Region Login}
  sSQL_SELECT_ALL_Login_WHERE_Benutzer:= 					  'SELECT * FROM Login WHERE Benutzername = :User';
	sSQL_SELECT_ALL_Login_WHERE_Benutzer_IDServer:= 	'SELECT * FROM Login WHERE Benutzername = :User AND ID_Server = :ID_Server';
	sSQL_SELECT_ALL_Login_WHERE_IDBenutzer_IDServer:= 'SELECT * FROM Login WHERE ID_MA_Stammdaten = :ID_MA_Stammdaten AND ID_Server = :ID_Server';
	sSQL_SELECT_COUNT_Login:= 									  		'Select Count(*) as Anzahl From Login';
	sSQL_UPDATE_ALL_login:= 												 	'UPDATE Login SET ID_MA_Stammdaten = :ID_Benutzer, ID_Server = :ID_Server, Benutzername =  :Benutzername, Passwort = :Passwort,  Firststart = :Firststart';
	sSQL_UPDATE_FIRSTSTART_login:= 								   	'UPDATE Login SET FirstStart=:Bool WHERE ID_MA_Stammdaten = :ID AND ID_Server = :ID_Server';
	sSQL_INSERT_All_login:= 												 	'INSERT INTO Login (ID_MA_Stammdaten, ID_Server, Benutzername, Passwort, Firststart) VALUES (:ID_Benutzer, :ID_Server, :Benutzername, :Passwort, :Firststart)';
  {$EndRegion Login}
  // Personal
  {$Region Personal}
  {$EndRegion Personal}
  // Online
  {$Region Online}
  sSQL_SELECT_TEXT_LASTBOOKING:=                    'Select Text From LastBooking';
  sSQL_UPDATE_TEXT_LASTBOOKING:=                    'Update LastBooking Set Text = :Text';
  {$EndRegion Online}
  // Buchungen
  {$Region Buchungen}
  {$EndRegion Buchungen}
  // Fehltage
  {$Region Fehltage}
  {$EndRegion Fehltage}
  // Monatswerte
  {$Region Monatswerte}
  {$EndRegion Monatswerte}
  end.
