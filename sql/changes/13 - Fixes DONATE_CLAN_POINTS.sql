ALTER PROCEDURE [DONATE_CLAN_POINTS]
	@strUserID			varchar(21),
	@sClanID			smallint,
	@nNationalPoints	int
AS
BEGIN TRAN
	UPDATE KNIGHTS SET ClanPointFund += @nNationalPoints WHERE IDNum = @sClanID
	IF (@@ERROR <> 0 OR @@ROWCOUNT = 0) GOTO ERROR
	
	UPDATE KNIGHTS_USER SET nDonatedNP += @nNationalPoints WHERE strUserId = @strUserID AND sIDNum = @sClanID
	IF (@@ERROR <> 0 OR @@ROWCOUNT = 0) GOTO ERROR
COMMIT TRAN
RETURN

ERROR:
	ROLLBACK TRAN