--------------------------------------------------------
--  파일이 생성됨 - 월요일-10월-14-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure ROULETTE_RESET
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMIN"."ROULETTE_RESET" AS
BEGIN
    UPDATE TBL_USER
    SET EVENT_ROUL = 'Y';
END;

/
--------------------------------------------------------
--  DDL for Procedure TBL_AUCTION_STATUS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMIN"."TBL_AUCTION_STATUS" AS
BEGIN
    FOR STATUS IN (SELECT ROUND(START_DAY - (SYSDATE + INTERVAL '9' HOUR), 16) START_DAY, 
    ROUND(END_DAY - (SYSDATE + INTERVAL '9' HOUR), 16) END_DAY, AUCTION_NO FROM TBL_AUCTION) LOOP
        IF STATUS.START_DAY <= 0 AND STATUS.END_DAY <= 0 THEN
            UPDATE TBL_AUCTION
            SET AUCTION_STATUS = 'E'
            WHERE AUCTION_NO = STATUS.AUCTION_NO;
        ELSIF STATUS.START_DAY <= 0 AND STATUS.END_DAY > 0 THEN
            UPDATE TBL_AUCTION
            SET AUCTION_STATUS = 'I'
            WHERE AUCTION_NO = STATUS.AUCTION_NO;
        ELSE 
            UPDATE TBL_AUCTION
            SET AUCTION_STATUS = 'F'
            WHERE AUCTION_NO = STATUS.AUCTION_NO;
        END IF;
    END LOOP;
    COMMIT;
END TBL_AUCTION_STATUS;

/
