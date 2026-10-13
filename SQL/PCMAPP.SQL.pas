unit PCMAPP.SQL;

interface
var
  // PCM-Time
  {$Region PCMTime}
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
  sSQL_SELECT_K_P1S_P1E_P2S_P2E_G: String;
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
  {$EndRegion PCMTime}
  // PCM-App
  {$Region PCMAPP}
    // Datenmodul
  {$Region Datenmodul}
  sSQL_CREATE_TABLE_ServerAPP,
  sSQL_CREATE_TABLE_LoginAPP,
  sSQL_CREATE_TABLE_AutologinAPP,
  sSQL_CREATE_TABLE_KontakteAPP,
  sSQL_CREATE_TABLE_KalenderAPP,
  sSQL_CREATE_TABLE_PasswordsAPP,
  sSQL_CREATE_TABLE_SerialsAPP,
  sSQL_CREATE_TABLE_EinnahmenAPP,
  sSQL_CREATE_TABLE_AusgabenAPP,
  sSQL_CREATE_TABLE_BelegeAPP,
  sSQL_CREATE_TABLE_GutscheinAPP,
  sSQL_CREATE_TABLE_CalAboAPP,
  sSQL_CREATE_TABLE_TempCalAPP,
  {$EndRegion Datenmodul}
  // Data
  {$Region Data}
  sSQL_SEL_NAME_SYSTEM,
	ssQL_SEL_PRAGMA_SYSTEM,
  {$EndRegion Data}
  // Server
  {$Region Server}
	sSQL_SEL_All_Server,
  sSQL_SEL_All_Server_WHERE_Bez,
	sSQL_SEL_All_Server_WHERE_ID,
  sSQL_SEL_COUNT_Server,
  sSQL_SEL_ID_Server,
	sSQL_UPD_All_Server_WHERE_ID,
	sSQL_INS_All_Server,
  sSQL_DEL_All_Server,
  {$EndRegion Server}
  // Autologin
  {$Region Autologin}
  sSQL_SEL_All_AUtologin,
  sSQL_SEL_COUNT_Autologin,
  sSQL_UPD_ALL_Autologin,
  sSQL_UPD_Benutzer_Autologin,
  sSQL_UPD_Desgin_Autologin,
  sSQL_UPD_DesginAPP_Autologin,
  sSQL_UPD_DesginWin_Autologin,
  sSQL_UPD_DEVICEID_Autologin,
  sSQL_UPD_DEVICETOKEN_Autologin,
  sSQL_UPD_Passwort_Autologin,
  sSQL_UPD_FINGER_Autologin,
  sSQL_UPD_LOCALACCOUNT_Autologin,
  sSQL_INS_All_Autologin,
  sSQL_INS_All_Autologin_Without_localaccount,
  {$EndRegion Autologin}
  // Login
  {$Region Login}
  sSQL_SEL_ALL_Login_WHERE_Benutzer,
	sSQL_SEL_ALL_Login_WHERE_BenutzerIDServer,
	sSQL_SEL_ALL_Login_WHERE_IDBenutzerIDServer,
	sSQL_SEL_COUNT_Login,
	sSQL_UPD_ALL_login,
	sSQL_UPD_FIRSTSTART_login,
	sSQL_INS_All_login,
  {$EndRegion Login}
  // Kontakte
  {$Region Kontakte}
	sSQL_SEL_ALL_Kontakte_WHERE_Deleted,
  sSQL_SEL_ALL_Kontakte_WHERE_ID,
  sSQL_SEL_Count_Kontakte_WHERE_Deleted,
  sSQL_UPD_ALL_Kontakte_WHERE_ID,
	sSQL_UPD_DELETED_Kontakte_WHERE_ID,
	sSQL_INS_ALL_Kontakte,
	sSQL_DEL_All_kontakte,
  {$EndRegion Kontakte}
  // kalender
  {$Region kalender}
  sSQL_SEL_Count_Kalender_WHERE_Deleted,
	sSQL_SEL_ALL_Kalender_WHERE_DeletedBegEndRec,
	sSQL_SEL_ALL_Kalender_WHERE_ReminderDate,
	sSQL_SEL_ALL_Kalender_WHERE_Deleted,
	sSQL_SEL_ALL_Kalender_WHERE_ID,
	sSQL_SEL_ALL_TempCal,
	sSQL_SEL_ALL_Kalender,
	sSQL_SEL_COUNT_TempCal,
	sSQL_INS_TempCal,
  sSQL_INS_ALL_Kalender,
	sSQL_UPD_ALL_Kalender_WHERE_ID,
	sSQL_UPD_Reminder_Kalender_WHERE_ID,
	sSQL_UPD_DeleteCalItem,
	sSQL_DEL_TempCal,
	{$EndRegion kalender}
  // Passwörter
  {$Region Passwort}
  sSQL_SEL_ALL_Password: String;
  sSQL_SEL_ALL_Password_WHERE_DELETED: String;
  sSQL_SEL_ALL_PASSWORD_WHERE_ID: String;
  sSQL_SEL_Count_Passwords_Where_Deleted: String;
  sSQL_UPD_ALL_PASSWORD_WHERE_ID: String;
  sSQL_UPD_DeletePWDItem: String;
  sSQL_INS_ALL_PASSWORD: String;
  sSQL_DEL_Password: String;
  {$EndRegion Passwort}
  // Serials
  {$Region Serials}
  sSQL_SEL_ALL_Serials_Where_Deleted: String;
  sSQL_SEL_ALL_Serials_Where_ID: String;
  sSQL_SEL_Count_Serials_Where_Deleted: String;
  sSQL_UPD_ALL_Serial_WHERE_ID: String;
  sSQL_UPD_Delete_SerialItem: String;
  sSQL_INS_ALL_Serial: String;
  {$EndRegion Serials}
  // Einnahmen
  {$Region Einnahmen}
  sSQL_SEL_ALL_Einnahmen_WHERE_DELETED: String;
  sSQL_SEL_ALL_Einnahmen_WHERE_ID: String;
  sSQL_SEL_QUelleBetrag_Einnahmen: String;
  sSQL_SEL_SUMBetrag_Einnahmen: String;
  sSQL_SEL_SUMFixBetrag_Einnahmen: String;
  sSQL_UPD_ALL_Einnahmen_WHERE_ID: String;
  sSQL_UPD_BetragFix_Einnahmen: String;
  sSQL_UPD_BetragNull_Einnahmen: String;
  sSQL_UPD_Delete_EinnahmeItem: String;
  sSQL_INS_ALL_Einnahme: String;
  {$EndRegion Einnahmen}
  // Ausgaben
  {$Region Ausgaben}
  sSQL_SEL_ALL_Ausgaben_WHERE_ID: String;
  sSQL_SEL_ALL_Ausgaben: String;
  sSQL_SEL_ALL_varKosten: String;
  sSQL_SEL_ALL_fixKosten: String;
  sSQL_SEL_SUMBetrag_fixKosten: String;
  sSQL_SEL_SUMFixBetrag_fixKosten: String;
  sSQL_SEL_SUMBetrag_varKosten: String;
  sSQL_SEL_SUMFixBetrag_varKosten: String;
  sSQL_UPD_ALL_Ausgaben_WHERE_ID: String;
  sSQL_UPD_BetragFix_Ausgaben: String;
  sSQL_UPD_BetragNull_Ausgaben: String;
  sSQL_UPD_Delete_AusgabeItem: String;
  sSQL_INS_ALL_Ausgaben: String;
  {$EndRegion Ausgaben}
  // Belege
  {$Region Belege}
  sSQL_SEL_ALL_Belege_WHERE_ID: String;
  sSQL_SEL_ALL_Belege: String;
  sSQL_SEL_COUNT_WHERE_DeletedMonthYear: String;
  sSQL_SEL_SUMBetrag_Belege: String;
  sSQL_UPD_ALL_WHERE_ID: String;
  sSQL_UPD_DeleteBelItem: String;
  sSQL_INS_ALL_Belege: String;
  {$EndRegion Belege}
  // Gutscheine
  {$Region Gutscheine}
  SQL_SEL_ALL_Gutscheine_Where_ID: String;
  SQL_SEL_ALL_Gutscheine_Where_Deleted: String;
  SQL_SEL_ALL_Gutscheine_Where_DeletedRestWert: String;
  sSQL_SEL_Count_Gutscheine_WHERE_Deleted: String;
  sSQL_SEL_SUMRestwert_Gutscheine_WHERE_Deleted: String;
  sSQL_UPD_ALL_Gutschein_WHERE_ID: String;
  sSQL_UPD_Del_Gutschein: String;
  sSQL_INS_ALL_Gutschein: String;
  {$EndRegion Gutscheine}
  // Kalenderabo
  {$Region Kalenderabo}
  sSQL_SEL_ALL_Calabo_WHERE_ID: String;
  sSQL_SEL_ALL_Calabo: String;
  sSQL_UPD_ALL_Calabo_WHERE_ID: String;
  sSQL_DEL_Calabo: String;
  sSQL_INS_ALL_CalAbo: String;
  {$EndRegion Kalenderabo}
  // ImporKontakte
 {$Region ImporKontakte}
  sSQL_SEL_ID_Kontakte_WHERE_NACHNAMEVORNAME: String;
  sSQL_INS_ALL_Kontakte_Statement: String;
  sSQL_INS_ALL_Kontakte_Values: String;
  {$EndRegion ImporKontakte}
  {$EndRegion PCMAPP}
implementation
begin
   // PCM-Time
  {$Region PCMTime}
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
																  									'Bezahlt Integer,' +
                                                    'SollAbziehen Integer);';
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
  sSQL_SELECT_K_P1S_P1E_P2S_P2E_G:=                 'SELECT *  FROM buchungen WHERE ' +
                                                    'Kommen > ''00:00:00.000'' OR ' +
                                                    'Pause1Beginn > ''00:00:00.000'' OR ' +
                                                    'Pause1Ende  > ''00:00:00.000'' OR ' +
                                                    'Pause2Beginn > ''00:00:00.000'' OR ' +
                                                    'Pause2Ende > ''00:00:00.000'' ' +
                                                    'ORDER BY Datum DESC ' +
                                                    'LIMIT 1';
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
  {$EndRegion PCMTime}
  // PCM-App
  {$Region PCMAPP}
  // Datamodul
  {$Region Datenmodul}
	sSQL_CREATE_TABLE_ServerAPP:=                			'CREATE TABLE IF NOT EXISTS Server ' +
																			  						'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
																			  						'Bezeichnung NVARCHAR(200),' +
																			  						'Hostname NVARCHAR(200),' +
																			  						'Port NVARCHAR(200));';
	sSQL_CREATE_TABLE_LoginAPP:=                 			'CREATE TABLE IF NOT EXISTS Login ' +
																				  					'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
																					  				'ID_MA_Stammdaten INTEGER,' +
																						  			'ID_Server INTEGER,' +
																							  		'Benutzername NVARCHAR(101),' +
																								  	'Passwort NVARCHAR(256),' +
																		  							'FirstStart Boolean);';
	sSQL_CREATE_TABLE_AutologinAPP:=             			'CREATE TABLE IF NOT EXISTS Auto_Login ' +
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
					  																				'DeviceToken NVARCHAR(255));';
	sSQL_CREATE_TABLE_KontakteAPP:=  									'CREATE TABLE IF NOT EXISTS Kontakte ' +
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
				  																					'Kontakte_ID INTEGER,'+
					  																				'Kontakte_Telefon BOOLEAN,' +
						  																			'Bild Memo,' +
							  																		'GeaendertAM DATETIME,' +
								  																	'Deleted BOOLEAN);';
	sSQL_CREATE_TABLE_KalenderAPP:=  									'CREATE TABLE IF NOT EXISTS kalender ' +
									  																'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
										  															'EventType integer,' +
											  														'Caption NVARCHAR(255),' +
												  													'Location NVARCHAR(255),' +
													  												'Message NMEMO,' +
														  											'Start DateTime,' +
															  										'Finish DateTime,'+
																  									'CompleteDay Boolean,' +
																	  								'Reminder Boolean,' +
																		  							'ReminderDate datetime,' +
																			  						'ReminderMinutesBeforeStart integer,' +
																				  					'Kalendername NVARCHAR(101),' +
																					  				'Wiederholungtext NVARCHAR(255),' +
																						  			'kalender_ID INTEGER,' +
																							  		'GeaendertAM TIMESTAMP,' +
																								  	'Deleted Boolean);';
	sSQL_CREATE_TABLE_PasswordsAPP:= 									'CREATE TABLE IF NOT EXISTS passwoerter ' +
  																									'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
	  																								'Bezeichnung NVARCHAR(101),' +
		  																							'user NVARCHAR(101),' +
			  																						'password NVARCHAR(101),' +
				  																					'link NVARCHAR(101),' +
					  																				'VPN_SharedSecret NVARCHAR(101),' +
						  																			'APP_IP NVARCHAR(101),'+
							  																		'APP_Port INTEGER,' +
								  																	'APP_Verschluesselung NVARCHAR(101),' +
									  																'MAIL_Posteingangsserver NVARCHAR(101),' +
										  															'MAIL_PosteingangsPort INTEGER,' +
											  														'MAIL_PosteingangsVerschluesselung NVARCHAR(101),' +
												  													'MAIL_Postausgangsserver NVARCHAR(101),'+
													  												'MAIL_PostausgangsPort integer,' +
														  											'MAIL_PostausgangsVerschluesselung NVARCHAR(101),' +
															  										'PWTyp NVARCHAR(101),' +
																  									'passwoerter_ID INTEGER,' +
																	  								'WLAN NVARCHAR(101),' +
																		  							'GeaendertAM TIMESTAMP,' +
																			  						'Deleted Boolean);';
	sSQL_CREATE_TABLE_SerialsAPP:=   			    				'CREATE TABLE IF NOT EXISTS Serials ' +
																						  			'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
																							  		'App NVARCHAR(101),' +
																								  	'USER  NVARCHAR(101),' +
  																									'Serial NVARCHAR(101),' +
	  																								'Bezeichnung NVARCHAR(101),' +
	  																								'Serials_ID INTEGER,' +
		  																							'GeaendertAM TIMESTAMP,' +
			  																						'Deleted Boolean);';
	sSQL_CREATE_TABLE_EinnahmenAPP:= 									'CREATE TABLE IF NOT EXISTS FinanzenEinnahmen ' +
				  																					'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
					  																				'Quelle NVARCHAR(101),' +
						  																			'Betrag DOUBLE,' +
							  																		'FixBetrag double,' +
								  																	'Bezeichnung NVARCHAR(101),' +
									  																'Finanzen_Einnahmen_ID INTEGER,' +
										  															'GeaendertAM TIMESTAMP,' +
											  														'Deleted Boolean);';
	sSQL_CREATE_TABLE_AusgabenAPP:=  									'CREATE TABLE IF NOT EXISTS FinanzenAusgaben  ' +
												  													'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
													  												'Name NVARCHAR(101),' +
														  											'Beschreibung NVARCHAR(101),' +
															  										'Kontonummer NVARCHAR(101),' +
																  									'Bankleitzahl NVARCHAR(101),' +
																	  								'Betrag double,' +
																		  							'FixBetrag double, '+
																			  						'Fixkosten logical,' +
																				  					'Gueltig_Monat integer,' +
																					  				'Gueltig_Jahr integer,' +
																						  			'Verwendungszweck NVARCHAR(101),' +
																							  		'Finanzen_Ausgaben_ID INTEGER,' +
																								  	'GeaendertAM TIMESTAMP,' +
																									  'Deleted Boolean);';
	sSQL_CREATE_TABLE_BelegeAPP:=    									'CREATE TABLE IF NOT EXISTS Belege ' +
  																									'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
	  																								'Nummer NVARCHAR(101),' +
		  																							'Datum Date,' +
			  																						'Aussteller NVARCHAR(101),' +
				  																					'Betrag DOUBLE,' +
					  																				'Kategorie Integer,' +
						  																			'Monat Integer,' +
							  																		'Jahr Integer,' +
								  																	'Belege_ID INTEGER,' +
									  																'GeaendertAM TIMESTAMP,' +
										  															'Deleted Boolean);';
	sSQL_CREATE_TABLE_GutscheinAPP:= 									'CREATE TABLE IF NOT EXISTS Gutschein ' +
  																									'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
	  																								'Nummer NVARCHAR(101),Bezeichnung NVARCHAR(101),Wert DOUBLE,RestWert DOUBLE,Datum Date,AbfragePin NVARCHAR(101),Gutschein_ID INTEGER,GeaendertAM TIMESTAMP,Deleted Boolean);';
	sSQL_CREATE_TABLE_CalAboAPP:=    									'CREATE TABLE IF NOT EXISTS kalender_config  ' +
		  																							'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
			  																						'Kalender NVARCHAR(101),' +
				  																					'Link NVARCHAR(101),' +
					  																				'Benutzer NVARCHAR(101),' +
						  																			'Passwort NVARCHAR(101),' +
							  																		'Erinnerung Boolean,' +
								  																	'ErinnerungVor integer,' +
									  																'LabelColor integer,' +
										  															'FontColor integer);';
	sSQL_CREATE_TABLE_TempCalAPP:=   									'CREATE TABLE IF NOT EXISTS TempCal ' +
											  														'(ID INTEGER PRIMARY KEY AUTOINCREMENT,' +
												  													'Text NVARCHAR(255),' +
													  												'Detail NVARCHAR(255),' +
														  											'Itemindex integer,' +
															  										'ID_Kalender integer,' +
  															  									'Start DateTime);';
  {$endRegion Datenmodul}
  // Data
  {$Region Data}
  sSQL_SEL_NAME_SYSTEM:= 													'SELECT name ' +
																									'FROM sqlite_master ' +
																									'WHERE type = ''table''';
	ssQL_SEL_PRAGMA_SYSTEM:= 												'PRAGMA user_Version';
  {$EndRegion Data}
  // Server
  {$Region Server}
	sSQL_SEL_All_Server:= 													'SELECT *  ' +
																									'FROM Server';
  sSQL_SEL_All_Server_WHERE_Bez:= 								'SELECT * ' +
																									'FROM Server  ' +
																									'WHERE Bezeichnung = :Bezeichnung';
	sSQL_SEL_All_Server_WHERE_ID:= 									'SELECT *  ' +
																									'FROM Server  ' +
																									'WHERE ID = :ID';
  sSQL_SEL_COUNT_Server:= 												'Select Count(*) as Anzahl ' +
																									'FROM Server';
  sSQL_SEL_ID_Server:= 														'Select ID ' +
																									'FROM Server';
	sSQL_UPD_All_Server_WHERE_ID:= 									'UPDATE Server ' +
																									'SET Bezeichnung = :Bez, Hostname = :Host, Port = :Port ' +
																									'WHERE ID = :ID';
	sSQL_INS_All_Server:= 													'INSERT INTO Server' +
																									'(Bezeichnung, Hostname, Port) ' +
																									'VALUES ' +
																									'(:Bez, :Host, :Port)';
	sSQL_DEL_All_Server:= 													'DELETE ' +
                                                  'FROM Server';
  {$EndRegion Server}
  // Autologin
  {$Region Autologin}
  sSQL_SEL_All_AUtologin:= 												'SELECT * ' +
																									'FROM Auto_login';
  sSQL_SEL_COUNT_Autologin:= 											'Select Count(*) as Anzahl ' +
																									'From Auto_login';
  sSQL_UPD_ALL_Autologin:= 												'UPDATE Auto_login ' +
																									'Set ID_MA_Stammdaten = 0, ID_Server = :ID_Server, Benutzername =  :Benutzername, Passwort = :Passwort, Autologin = :Autologin, Design = :Design, Localaccount = :Localaccount ';
  sSQL_UPD_Benutzer_Autologin:= 									'Update Auto_Login ' +
																									'Set Benutzername = :Benutzername';
  sSQL_UPD_Desgin_Autologin := 										'Update Auto_Login ' +
																									'Set Design = :Design';
  sSQL_UPD_DesginAPP_Autologin := 								'Update Auto_Login ' +
																									'Set DesignApp = :Design';
  sSQL_UPD_DesginWin_Autologin := 								'Update Auto_Login ' +
																									'Set DesignWin = :Design';
  sSQL_UPD_DEVICEID_Autologin:= 									'Update Auto_Login ' +
																									'Set DeviceID = :DeviceID';
  sSQL_UPD_DEVICETOKEN_Autologin:= 								'Update Auto_Login ' +
																									'Set DeviceToken = :DeviceToken';
  sSQL_UPD_Passwort_Autologin:= 									'Update Auto_Login ' +
																									'Set Passwort = :Passwort';
  sSQL_UPD_FINGER_Autologin:= 										'UPDATE Auto_Login ' +
																									'SET FingerAuthenticate = :Finger';
  sSQL_UPD_LOCALACCOUNT_Autologin:= 							'UPDATE Auto_login ' +
																									'SET Localaccount = :Localaccount ';
  sSQL_INS_All_Autologin:=												'INSERT INTO Auto_login ' +
																									'(ID_MA_Stammdaten, ID_Server, Benutzername, Passwort, Autologin, Design, DesignApp,DesignWin,Localaccount) ' +
																									'VALUES ' +
																									'(0, :ID_Server, :Benutzername, :Passwort, :Autologin, :Design,:DesignApp,:DesignWin, :Localaccount)';
  sSQL_INS_All_Autologin_Without_localaccount:= 	'INSERT INTO Auto_Login ' +
																									'(ID_MA_Stammdaten, ID_Server, Benutzername, Passwort, Autologin, Design, DesignApp,DesignWin) ' +
																									'VALUES ' +
																									'(:ID, :ID_Server, :Benutzername, :Passwort, :Autologin, :Design,:DesignApp,:DesignWin)';
  {$EndRegion Autologin}
  // Login
  {$Region Login}
  sSQL_SEL_ALL_Login_WHERE_Benutzer:= 						'SELECT * ' +
                                                  'FROM Login ' +
                                                  'WHERE Benutzername = :User';
	sSQL_SEL_ALL_Login_WHERE_BenutzerIDServer:= 		'SELECT * ' +
                                                  'FROM Login ' +
                                                  'WHERE Benutzername = :User AND ID_Server = :ID_Server';
	sSQL_SEL_ALL_Login_WHERE_IDBenutzerIDServer:= 	'SELECT *  ' +
                                                  'FROM Login ' +
                                                  'WHERE ID_MA_Stammdaten = :ID_MA_Stammdaten AND ID_Server = :ID_Server';
	sSQL_SEL_COUNT_Login:= 													'Select Count(*) as Anzahl ' +
                                                  'From Login';
	sSQL_UPD_ALL_login:= 														'UPDATE Login ' +
                                                  'SET ID_MA_Stammdaten = :ID_Benutzer, ID_Server = :ID_Server, Benutzername =  :Benutzername, Passwort = :Passwort,  Firststart = :Firststart';
	sSQL_UPD_FIRSTSTART_login:= 										'UPDATE Login ' +
                                                  'SET FirstStart=:Bool ' +
                                                  'WHERE ID_MA_Stammdaten = :ID AND ID_Server = :ID_Server';
	sSQL_INS_All_login:= 														'INSERT INTO Login ' +
                                                  '(ID_MA_Stammdaten, ID_Server, Benutzername, Passwort, Firststart) ' +
                                                  'VALUES ' +
                                                  '(:ID_Benutzer, :ID_Server, :Benutzername, :Passwort, :Firststart)';
  {$EndRegion Login}
  // Kontakte
  {$Region Kontakte}
	sSQL_SEL_ALL_Kontakte_WHERE_Deleted:=     			'SELECT ID, Nachname, Vorname, Firma,Bild,Kontakte_ID ' +
																									'FROM Kontakte ' +
																									'WHERE (Deleted <> true or Deleted is null) ' +
                                                  'order by Vorname, nachname';
  sSQL_SEL_ALL_Kontakte_WHERE_ID:=                'SELECT Anrede,Vorname,Nachname,Strasse,PLZ,Ort,Telefon,Handy,Email,Geburtsdatum,Geschlecht,Familienstand,Staatsangehoerigkeit,Konfession,Firma,StrasseFirma,PLZFirma,OrtFirma,TelefonFirma,HandyFirma,EmailFirma,Bild ' +
                                                  'FROM Kontakte ' +
                                                  'WHERE ID = :ID';
  sSQL_SEL_Count_Kontakte_WHERE_Deleted:=   			'SELECT COUNT(*) as Anzahl ' +
                                                  'FROM Kontakte ' +
                                                  'WHERE IFNULL(Deleted,0) = 0';
  sSQL_UPD_ALL_Kontakte_WHERE_ID:=                'Update Kontakte ' +
                                                  'SET Anrede = :Anrede,Vorname = :Vorname,Nachname = :Nachname,Strasse = :Strasse,PLZ = :PLZ, Ort = :Ort,Telefon = :Telefon,Handy = :Handy,Email = :Email,Geburtsdatum = :Geburtsdatum,Geschlecht = :Geschlecht,Familienstand = :Familienstand,Staatsangehoerigkeit = :Staatsangehoerigkeit,Konfession =:Konfession,Firma = :Firma,StrasseFirma = :StrasseFirma,PLZFirma = :PLZFirma,OrtFirma = :OrtFirma,TelefonFirma = :TelefonFirma,HandyFirma = :HandyFirma,EmailFirma = :EmailFirma,Geaendertam = DateTime() ' +
                                                  'WHERE ID = :ID';
	sSQL_UPD_DELETED_Kontakte_WHERE_ID:= 						'Update Kontakte ' +
																									'Set Deleted = True,Geaendertam = DateTime() ' +
																									'WHERE ID = :ID';
	sSQL_INS_ALL_Kontakte:= 												'INSERT INTO Kontakte ' +
																									'(Anrede,Vorname,Nachname,Strasse,PLZ,Ort,Telefon,Handy,Email,Geburtsdatum,Geschlecht,Familienstand,Staatsangehoerigkeit,Konfession,Firma,StrasseFirma,PLZFirma,OrtFirma,TelefonFirma,HandyFirma,EmailFirma,Geaendertam) ' +
																									'Values ' +
																									'(:Anrede,:Vorname,:Nachname,:Strasse,:PLZ,:Ort,:Telefon,:Handy,:Email,:Geburtsdatum,:Geschlecht,:Familienstand,:Staatsangehoerigkeit,:Konfession,:Firma,:StrasseFirma,:PLZFirma,:OrtFirma,:TelefonFirma,:HandyFirma,:EmailFirma,DateTime())';
	sSQL_DEL_All_kontakte:= 												'Delete ' +
                                                  'From Kontakte';
  {$EndRegion Kontakte}
  // kalender
  {$Region kalender}
  sSQL_SEL_Count_Kalender_WHERE_Deleted:= 				'SELECT COUNT(*) as Anzahl ' +
																									'FROM Kalender ' +
																									'WHERE IFNULL(Deleted,0) = 0';
	sSQL_SEL_ALL_Kalender_WHERE_DeletedBegEndRec:= 	'SELECT * ' +
																									'FROM kalender ' +
																									'WHERE (DATE(START) = :Datum and IFNULL(Deleted,0) = 0) OR (wiederholungtext <> '''' and DATE(START) <= :Datum ) ' +
																									'ORDER BY TIME(START)';
	sSQL_SEL_ALL_Kalender_WHERE_ReminderDate:= 			'SELECT * ' +
																									'FROM kalender ' +
																									'WHERE Reminder = 1 AND DateTime(ReminderDate) <= DateTime(:DateTime) ' +
  																								'ORDER BY ReminderDate';
	sSQL_SEL_ALL_Kalender_WHERE_Deleted:= 					'SELECT ID, Caption, Start,Finish, CompleteDay,kalendername, wiederholungtext ' +
																									'FROM Kalender ' +
																									'WHERE (Deleted <> true or deleted is null) ' +
																									'order by start asc';
	sSQL_SEL_ALL_Kalender_WHERE_ID:=      					'SELECT EventType, Caption,Location, Message,Start,Finish,CompleteDay,Reminder,ReminderDate,ReminderMinutesBeforeStart,Kalendername ' +
                                                  'FROM Kalender ' +
                                                  'WHERE ID = :ID';
	sSQL_SEL_ALL_TempCal:= 													'SELECT ID, Text, Detail, Itemindex, ID_Kalender ' +
																									'FROM TempCal ' +
																									'order by start asc';
	sSQL_SEL_ALL_Kalender:= 												'SELECT ID, Caption, Start,Finish, CompleteDay,kalendername,wiederholungtext ' +
																									'FROM Kalender ' +
																									'WHERE (Deleted <> true or deleted is null) ' +
																									'order by start asc';
	sSQL_SEL_COUNT_TempCal:= 												'Select Count(*) as Anzahl ' +
																									'FROM TempCal WHERE Text = :Text';
	sSQL_INS_TempCal:= 															'Insert INTO TempCal ' +
																									'(Text,Detail,Itemindex,Start,ID_Kalender) ' +
																									'Values ' +
																									'(:Text,:Detail,:Itemindex,:Start,:ID_Kalender)';
  sSQL_INS_ALL_Kalender:=                        'INSERT INTO Kalender (EventType,Caption,Location,Message,Start,Finish,CompleteDay,Reminder,ReminderDate,ReminderMinutesBeforeStart,Kalendername,Geaendertam) '+
                                                 'VALUES ' +
                                                 '(:EventType,:Caption,:Location,:Message,:Start,:Finish,:CompleteDay,:Reminder,:ReminderDate,:ReminderMinutesBeforeStart,:Kalendername,DateTime())';
	sSQL_UPD_ALL_Kalender_WHERE_ID:=                'Update Kalender SET EventType = :EventType, Caption = :Caption,Location = :Location,Message = :Message,Start = :Start,Finish = :Finish,CompleteDay = :CompleteDay,Reminder = :Reminder,ReminderDate = :ReminderDate, ReminderMinutesBeforeStart = :ReminderMinutesBeforeStart, Kalendername = :Kalendername,Geaendertam = DateTime() '+
                                                  'WHERE ID = :ID';
	sSQL_UPD_Reminder_Kalender_WHERE_ID:= 					'Update kalender ' +
																									'SET Reminder = 0 ' +
																									'WHERE ID = :ID';
	sSQL_UPD_DeleteCalItem:= 												'Update Kalender ' +
																									'SET Deleted = True,Geaendertam = DateTime() ' +
																									'WHERE ID = :ID';
	sSQL_DEL_TempCal:= 															'Delete ' +
                                                  'From TempCal';
	{$EndRegion kalender}
  // Passwörter
  {$Region Passwords}
  sSQL_SEL_ALL_Password:=                         'SELECT * ' +
                                                  'FROM passwoerter';
  sSQL_SEL_ALL_Password_WHERE_DELETED:=   				'SELECT ID, Bezeichnung, PWTyp ' +
																									'FROM passwoerter ' +
																									'WHERE (Deleted <> true or deleted is null) ' +
																									'order by Bezeichnung asc';
  sSQL_SEL_ALL_PASSWORD_WHERE_ID:=                'SELECT PWTYP,Bezeichnung,user,password,link,VPN_SharedSecret,APP_IP,APP_Port,APP_Verschluesselung,MAIL_Posteingangsserver,MAIL_PosteingangsPort,MAIL_PosteingangsVerschluesselung,MAIL_Postausgangsserver,MAIL_PostausgangsPort,MAIL_PostausgangsVerschluesselung,WLAN ' +
                                                  'FROM Passwoerter ' +
                                                  'WHERE ID = :ID';
  sSQL_SEL_Count_Passwords_Where_Deleted:= 				'SELECT COUNT(*) as Anzahl ' +
																									'FROM passwoerter ' +
																									'Where IFNULL(Deleted,0) = 0';
  sSQL_UPD_ALL_PASSWORD_WHERE_ID:=                'Update Passwoerter ' +
                                                  'SET Bezeichnung = :Bezeichnung,user = :user,password = :password,link = :link,VPN_SharedSecret = :VPN_SharedSecret,APP_IP = :APP_IP,APP_Port = :APP_Port,APP_Verschluesselung = :APP_Verschluesselung,MAIL_Posteingangsserver = :MAIL_Posteingangsserver,MAIL_PosteingangsPort = :MAIL_PosteingangsPort,MAIL_PosteingangsVerschluesselung = :MAIL_PosteingangsVerschluesselung,MAIL_Postausgangsserver = :MAIL_Postausgangsserver,MAIL_PostausgangsPort = :MAIL_PostausgangsPort,MAIL_PostausgangsVerschluesselung = :MAIL_PostausgangsVerschluesselung,PWTyp = :PWTyp,WLAN = :WLAN,Geaendertam = DateTime() '+
                                                  'WHERE ID = :ID';
  sSQL_UPD_DeletePWDItem:= 												'Update passwoerter ' +
																									'Set Deleted = True,Geaendertam = DateTime() ' +
																									'WHERE ID = :ID';
  sSQL_INS_ALL_PASSWORD:=                         'INSERT INTO Passwoerter (Bezeichnung,user,password,link,VPN_SharedSecret,APP_IP,APP_Port,APP_Verschluesselung,MAIL_Posteingangsserver,MAIL_PosteingangsPort,MAIL_PosteingangsVerschluesselung,MAIL_Postausgangsserver,MAIL_PostausgangsPort,MAIL_PostausgangsVerschluesselung,PWTyp,WLAN,Geaendertam)'+
                                                  'VALUES ' +
                                                  '(:Bezeichnung,:user,:password,:link,:VPN_SharedSecret,:APP_IP,:APP_Port,:APP_Verschluesselung,:MAIL_Posteingangsserver,:MAIL_PosteingangsPort,:MAIL_PosteingangsVerschluesselung,:MAIL_Postausgangsserver,:MAIL_PostausgangsPort,:MAIL_PostausgangsVerschluesselung,:PWTyp,:WLAN,DateTime())';
  sSQL_DEL_Password:=                             'Delete ' +
                                                  'From passwoerter';

  {$EndRegion Passwords}
  // Serials
  {$Region Serials}
  sSQL_SEL_ALL_Serials_Where_Deleted:= 						'SELECT ID, App,Bezeichnung ' +
																									'FROM Serials ' +
																									'WHERE (Deleted <> true or deleted is null) ' +
																									'order by App asc';
  sSQL_SEL_ALL_Serials_Where_ID:=                 'SELECT App,USER,Serial,Bezeichnung ' +
                                                  'FROM Serials ' +
                                                  'WHERE ID = :ID';
  sSQL_SEL_Count_Serials_Where_Deleted:= 					'SELECT COUNT(*) as Anzahl ' +
																									'FROM Serials ' +
																									'Where IFNULL(Deleted,0) = 0';
  sSQL_UPD_ALL_Serial_WHERE_ID:=                  'Update Serials ' +
                                                  'SET App = :App, USER = :USER,Serial = :Serial,Bezeichnung = :Bezeichnung, Geaendertam = DateTime() ' +
                                                  'WHERE ID = :ID';
  sSQL_UPD_Delete_SerialItem:= 										'Update Serials ' +
                                                  'Set Deleted = True,Geaendertam = DateTime() ' +
                                                  'WHERE ID = :ID';
  sSQL_INS_ALL_Serial:=   										    'INSERT INTO Serials ' +
                                                  '(App,USER,Serial,Bezeichnung,Geaendertam) '+
                                                  'VALUES ' +
                                                  '(:App,:USER,:Serial,:Bezeichnung,DateTime())';
  {$EndRegion Serials}
  // Einnahmen
  {$Region Einnahmen}
  sSQL_SEL_ALL_Einnahmen_WHERE_DELETED:=          'SELECT ID, Quelle, Bezeichnung, Betrag ' +
                                                  'FROM FinanzenEinnahmen ' +
                                                  'WHERE (Deleted <> true or deleted is null) ' +
                                                  'order by Quelle asc';
  sSQL_SEL_ALL_Einnahmen_WHERE_ID:=               'SELECT Quelle,Bezeichnung,Betrag,FixBetrag ' +
                                                  'FROM FinanzenEinnahmen ' +
                                                  'WHERE ID = :ID';
  sSQL_SEL_QUelleBetrag_Einnahmen:=  							'Select Quelle, IFnull(Betrag,0) as Einnahmen ' +
																									'FROM FinanzenEinnahmen ' +
																									'WHERE (Deleted <> true or deleted is null) and Betrag > 0 ' +
																									'Order by Quelle';
  sSQL_SEL_SUMBetrag_Einnahmen:= 									'Select IFnull(Sum(Betrag),0)as Einnahmen ' +
																									'FROM FinanzenEinnahmen ' +
																									'WHERE (Deleted <> true or deleted is null) ';
  sSQL_SEL_SUMFixBetrag_Einnahmen:=								'Select IFnull(Sum(FixBetrag),0)as Einnahmen ' +
																									'FROM FinanzenEinnahmen ' +
																									'WHERE (Deleted <> true or deleted is null)';
  sSQL_UPD_ALL_Einnahmen_WHERE_ID:= 	  		      'Update FinanzenEinnahmen SET Quelle = :Quelle, Bezeichnung = :Bezeichnung,Betrag = :Betrag, FixBetrag = :FixBetrag,Geaendertam = DateTime() '+
                                                  'WHERE ID = :ID';
  sSQL_UPD_BetragFix_Einnahmen:= 									'Update FinanzenEinnahmen ' +
                                                  'Set Betrag = FixBetrag, GeaendertAM = DateTime()';
  sSQL_UPD_BetragNull_Einnahmen:= 								'Update FinanzenEinnahmen ' +
                                                  'Set Betrag = 0, GeaendertAM = DateTime()';
  sSQL_UPD_Delete_EinnahmeItem:= 									'Update FinanzenEinnahmen ' +
                                                  'Set Deleted = True,Geaendertam = DateTime() ' +
                                                  'WHERE ID = :ID';
  sSQL_INS_ALL_Einnahme:=       									'INSERT INTO FinanzenEinnahmen ' +
                                                  '(Quelle,Bezeichnung,Betrag,FixBetrag,Geaendertam) '+
                                                  'VALUES ' +
                                                  '(:Quelle,:Bezeichnung,:Betrag,:FixBetrag,DateTime())';
  {$EndRegion Einnahmen}
  // Ausgaben
  {$Region Ausgaben}


  sSQL_SEL_ALL_Ausgaben_WHERE_ID:=                'SELECT Name,Beschreibung,Kontonummer,Bankleitzahl,Betrag,FixBetrag,Fixkosten,Gueltig_Monat,Gueltig_Jahr,Verwendungszweck ' +
                                                  'FROM FinanzenAusgaben ' +
                                                  'WHERE ID = :ID';
  sSQL_SEL_ALL_Ausgaben:=                         'SELECT ID,Name, Beschreibung, Betrag ' +
                                                  'FROM FinanzenAusgaben ' +
                                                  'WHERE (Deleted <> true or deleted is null)  order by Name asc';
  sSQL_SEL_ALL_varKosten:=   											'Select Name,IFnull(Betrag,0)as varKosten ' +
																									'FROM FinanzenAusgaben ' +
																									'WHERE (Deleted <> true or deleted is null)  and fixkosten = :Fixkosten and Gueltig_Monat = :Monat and Gueltig_Jahr = :Jahr ' +
																									'order by name';
  sSQL_SEL_ALL_fixKosten:=   											'Select name,IFnull(Betrag,0)as fixKosten ' +
																									'FROM FinanzenAusgaben ' +
																									'WHERE (Deleted <> true or deleted is null)  and fixkosten = :Fixkosten ' +
																									'order by name';
  sSQL_SEL_SUMBetrag_fixKosten:= 									'Select IFnull(Sum(Betrag),0)as fixKosten ' +
																									'FROM FinanzenAusgaben ' +
																									'WHERE (Deleted <> true or deleted is null)  and fixkosten = :Fixkosten ' +
																									'order by name';
  sSQL_SEL_SUMFixBetrag_fixKosten:=								'Select IFnull(Sum(FixBetrag),0)as fixKosten ' +
																									'FROM FinanzenAusgaben ' +
																									'WHERE (Deleted <> true or deleted is null)  and fixkosten = :Fixkosten';
  sSQL_SEL_SUMBetrag_varKosten:=   								'Select IFnull(Sum(Betrag),0)as varKosten ' +
																									'FROM FinanzenAusgaben ' +
																									'WHERE (Deleted <> true or deleted is null)  and fixkosten = :Fixkosten and Gueltig_Monat = :Monat and Gueltig_Jahr = :Jahr';
  sSQL_SEL_SUMFixBetrag_varKosten:= 							'Select IFnull(Sum(FixBetrag),0)as varKosten ' +
																									'FROM FinanzenAusgaben ' +
																									'WHERE (Deleted <> true or deleted is null)  and fixkosten = :Fixkosten and Gueltig_Monat = :Monat and Gueltig_Jahr = :Jahr';
  sSQL_UPD_ALL_Ausgaben_WHERE_ID:=                'Update FinanzenAusgaben SET Name = :Quelle, Beschreibung = :Bezeichnung,Betrag = :Betrag,FixBetrag = :FixBetrag,Kontonummer = :Kontonummer,Bankleitzahl = :Bankleitzahl ,Fixkosten = :Fixkosten,Gueltig_Monat = :Monat, Gueltig_Jahr = :Jahr,Verwendungszweck = :Verwendungszweck,Geaendertam = DateTime() '+
                                                  'WHERE ID = :ID';
  sSQL_UPD_BetragFix_Ausgaben:= 									'Update FinanzenAusgaben ' +
                                                  'Set Betrag = FixBetrag, GeaendertAM = DateTime()';
  sSQL_UPD_BetragNull_Ausgaben:= 							  	'Update FinanzenAusgaben ' +
                                                  'Set Betrag = 0, GeaendertAM = DateTime()';
  sSQL_UPD_Delete_AusgabeItem:= 									'Update FinanzenAusgaben ' +
                                                  'Set Deleted = True,Geaendertam = DateTime() ' +
                                                  'WHERE ID = :ID';
  sSQL_INS_ALL_Ausgaben:=                         'INSERT INTO FinanzenAusgaben (Name,Beschreibung,Betrag,FixBetrag,Kontonummer,Bankleitzahl,Fixkosten,Gueltig_Monat,Gueltig_Jahr,Verwendungszweck,Geaendertam) '+
                                                  'VALUES ' +
                                                  '(:Quelle,:Bezeichnung,:Betrag,:FixBetrag,:Kontonummer,:Bankleitzahl,:Fixkosten,:Monat,:Jahr,:Verwendungszweck,DateTime())';



  {$EndRegion Ausgaben}
  // Belege
  {$Region Belege}
  sSQL_SEL_ALL_Belege_WHERE_ID:=                  'SELECT Nummer,Datum,Aussteller,Betrag,Kategorie,Monat,Jahr ' +
                                                  'FROM Belege ' +
                                                  'WHERE ID = :ID';
  sSQL_SEL_ALL_Belege:=                           'SELECT ID, Nummer, Aussteller, Betrag,Datum ' +
                                                  'FROM Belege ' +
                                                  'WHERE (Deleted <> true or deleted is null)  order by Datum asc';
  sSQL_SEL_COUNT_Where_DeletedMonthYear:= 				'SELECT Count(*) as Anzahl ' +
																									'FROM Belege ' +
																									'Where Monat = :Monat and Jahr = :Jahr AND IFNULL(Deleted,0) = 0';
  sSQL_SEL_SUMBetrag_Belege:=  										'SELECT Sum(IFNULL(Betrag,0)) as Anzahl ' +
																									'FROM Belege ' +
																									'Where Monat = :Monat and Jahr = :Jahr AND IFNULL(Deleted,0) = 0';
  sSQL_UPD_ALL_WHERE_ID:=                         'Update Belege SET Nummer = :Nummer, Datum = :Datum,Aussteller = :Aussteller,Betrag = :Betrag,Kategorie = :Kategorie,Monat =:Monat,Jahr = :Jahr,Geaendertam = DateTime() '+
                                                  'WHERE ID = :ID';
  sSQL_UPD_DeleteBelItem:= 												'Update Belege ' +
																									'Set Deleted = True,Geaendertam = DateTime() ' +
																									'WHERE ID = :ID';
  sSQL_INS_ALL_Belege:=                           'INSERT INTO Belege ' +
                                                  '(Nummer,Datum,Aussteller,Betrag,Kategorie,Monat,Jahr,Geaendertam) '+
                                                  'VALUES ' +
                                                  '(:Nummer,:Datum,:Aussteller,:Betrag,:Kategorie,:Monat,:Jahr,DateTime())';
  {$EndRegion Belege}
  // Gutscheine
  {$Region Gutscheine}

  SQL_SEL_ALL_Gutscheine_Where_ID:=               'SELECT Nummer,Bezeichnung,Wert,RestWert,Datum,AbfragePin ' +
                                                  'FROM Gutschein ' +
                                                  'WHERE ID = :ID';
  SQL_SEL_ALL_Gutscheine_Where_Deleted:=          'SELECT ID, Nummer, Bezeichnung, Wert, RestWert, Datum, AbfragePin, Gutschein_ID ' +
                                                  'FROM Gutschein ' +
                                                  'WHERE (Deleted <> true or Deleted is null) order by Datum';
  SQL_SEL_ALL_Gutscheine_Where_DeletedRestWert:=  'SELECT ID, Nummer, Bezeichnung, Wert, RestWert, Datum, AbfragePin, Gutschein_ID ' +
                                                  'FROM Gutschein ' +
                                                  'WHERE RestWert <> 0 and  (Deleted <> true or Deleted is null) ' +
                                                  'order by Datum';
  sSQL_SEL_Count_Gutscheine_Where_Deleted:= 			'SELECT Count(*) as Anzahl ' +
																									'FROM Gutschein ' +
																									'Where IFNULL(Deleted,0) = 0';
  sSQL_SEL_SUMRestwert_Gutscheine_Where_Deleted:= 'SELECT Sum(IFNULL(Restwert,0)) as Anzahl ' +
																									'FROM Gutschein ' +
																									'Where IFNULL(Deleted,0) = 0';
  sSQL_UPD_ALL_Gutschein_WHERE_ID:=               'Update Gutschein SET Nummer = :Nummer,Bezeichnung = :Bezeichnung,Datum = :Datum,Wert = :Wert,Restwert = :Restwert, AbfragePin = :AbfragePin,Geaendertam = DateTime() '+
                                                  'WHERE ID = :ID';
  sSQL_UPD_Del_Gutschein:=                        'Update Gutschein ' +
                                                  'Set Deleted = True,Geaendertam = DateTime() ' +
                                                  'WHERE ID = :ID';
  sSQL_INS_ALL_Gutschein:=                        'INSERT INTO Gutschein ' +
                                                  '(Nummer,Bezeichnung,Datum,Wert,Restwert,AbfragePin,Geaendertam) ' +
                                                  'Values ' +
                                                  '(:Nummer,:Bezeichnung,:Datum,:Wert,:Restwert,:AbfragePin,DateTime())';
  {$EndRegion Gutscheine}
  // Kalenderabo
  {$Region Kalenderabo}

  sSQL_SEL_ALL_Calabo_WHERE_ID:=                  'SELECT Kalender, Link, Benutzer, Passwort, Erinnerung, ErinnerungVor ' +
                                                  'FROM Kalender_Config ' +
                                                  'WHERE ID = :ID';
  sSQL_SEL_ALL_Calabo:=  													'SELECT ID, Kalender, Link ' +
																									'FROM kalender_config ' +
																									'order by Kalender asc';
  sSQL_UPD_ALL_Calabo_WHERE_ID:=                  'Update Kalender_Config SET Kalender = :Kalender, Link = :Link,Benutzer = :Benutzer,Passwort = :Passwort,Erinnerung = :Erinnerung,ErinnerungVor = :ErinnerungVor '+
                                                  'WHERE ID = :ID';
  sSQL_DEL_Calabo:= 															'Delete ' +
																									'FROM kalender_config ' +
																									'WHERE ID = :ID';
  sSQL_INS_ALL_CalAbo:=                           'INSERT INTO Kalender_Config ' +
                                                  '(Kalender, Link, Benutzer, Passwort, Erinnerung, ErinnerungVor) ' +
                                                  'VALUES ' +
                                                  '(:Kalender, :Link, :Benutzer, :Passwort, :Erinnerung, :ErinnerungVor)';
  {$EndRegion Kalenderabo}
  // Import Kontakte
  {$Region ImporKontakte}

  sSQL_SEL_ID_Kontakte_WHERE_NACHNAMEVORNAME:=    'SELECT ID ' +
                                                  'FROM Kontakte ' +
                                                  'WHERE Nachname = :Nachname AND Vorname = :Vorname';
  sSQL_INS_ALL_Kontakte_Statement:=               'INSERT INTO Kontakte ' +
                                                  '(Kontakte_Telefon,Geaendertam,Firma,Vorname,Nachname,Telefon,Handy,TelefonFirma,HandyFirma,Geburtsdatum,Bild,Email,EmailFirma,Strasse,PLZ,Ort,StrasseFirma,PLZFirma,OrtFirma';
  sSQL_INS_ALL_Kontakte_Values:=                  ' VALUES ' +
                                                  '(True,DateTime(),:Firma,:Vorname,:Nachname,:Telefon,:Handy,:TelefonFirma,:HandyFirma,:Geburtsdatum,:Bild,:Email,:EmailFirma,:Strasse,:PLZ,:Ort,:StrasseFirma,:PLZFirma,:OrtFirma';
  {$EndRegion ImporKontakte}
  {$EndRegion PCMAPP}
end.
