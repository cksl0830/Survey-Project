create or replace TRIGGER TRI_INSERT_AUTH -- �궗�슜�옄 異붽��떆 auth�뿉 �옄�룞�쑝濡� ROLE_USER濡� 異붽��릺�룄濡� �꽕�젙
AFTER
    INSERT ON tbl_member
    FOR EACH ROW -- �뻾�듃由ш굅 �븘�닔 �꽑�뼵
BEGIN
    INSERT INTO tbl_auth(member_seq) VALUES
    (:new.member_seq);
END;
/
-- 1�씪寃쎌슦�뿏 �벑濡앺븳 �꽕臾몄“�궗�뿉 �뙎湲��씠 異붽��맆 寃쎌슦 tbl_notice�뿉 �븣由� �벑濡�
-- 2�씪寃쎌슦�뿏 �벑濡앺븳 �꽕臾몄“�궗�뿉 �늻援곌� 李몄뿬�븷 寃쎌슦 tbl_notice�뿉 �븣由� �벑濡�

CREATE OR REPLACE TRIGGER TRI_INSERT_NOTICE_SURVEY_REPLY
AFTER
    INSERT ON tbl_reply
    FOR EACH ROW -- �뻾�듃由ш굅 �븘�닔 �꽑�뼵
DECLARE    
    receive_member NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT member_seq 
            INTO receive_member
        FROM tbl_survey 
        WHERE survey_seq = :new.survey_seq;
        
        INSERT INTO tbl_notice
        (notice_seq, recieve_member_seq, notice_member_seq, survey_seq, reply_seq, survey_result_seq, notice_message, notice_type, notice_regdate, notice_readdate)
        VALUES
        (seq_notice.nextval, receive_member, :new.member_seq, :new.survey_seq, :new.reply_seq, null, '%s'||'�떂�씠'|| '%s'||'�꽕臾몄뿉 �뙎湲��쓣 �궓湲곗뀲�뒿�땲�떎.', 1, sysdate, null);
    END IF;
END;

/

--tbl_survey�쓽 �옉�꽦�옄瑜� �븣湲곗쐞�빐 �닾�몴�븳 踰덊샇�쓽 tbl_survey瑜� join�빐�꽌 �옉�꽦�옄瑜� 李얜뒗�떎. (res�뒗 �듃由ш굅 �씠由꾩씠 30湲��옄 �꽆�뼱媛�硫� �븞�릺�꽌 吏쒕쫫)

CREATE OR REPLACE TRIGGER TRI_INSERT_NOTICE_SURVEY_RES
AFTER
    INSERT ON tbl_survey_result
    FOR EACH ROW -- �뻾�듃由ш굅 �븘�닔 �꽑�뼵
DECLARE    
    receive_member NUMBER;
    var_survey_seq NUMBER;
BEGIN
    IF INSERTING THEN
        SELECT tbl_survey.member_seq, tbl_survey.survey_seq  
            INTO receive_member, var_survey_seq
        FROM tbl_survey_item
        JOIN tbl_survey ON tbl_survey.survey_seq = tbl_survey_item.survey_seq
        WHERE survey_item_seq = :new.survey_item_seq;
        
        INSERT INTO tbl_notice
        (notice_seq, recieve_member_seq, notice_member_seq, survey_seq, reply_seq, survey_result_seq, notice_message, notice_type, notice_regdate, notice_readdate)
        VALUES
        (seq_notice.nextval, receive_member, :new.member_seq, var_survey_seq, null, :new.survey_result_seq, '%s'||'�떂�씠 '||'%s'||'�꽕臾몄뿉 李몄뿬�븯���뒿�땲�떎.', 2, sysdate, null);
    END IF;
END;
/