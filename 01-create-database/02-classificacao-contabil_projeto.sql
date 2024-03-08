CREATE TABLE SERVDESK.CLASSIF_CONTABIL_PRJ(
    ID_CLASSIF_CONTABIL_PRJ INT NOT NULL PRIMARY KEY,
    ID_CLASSIFICACAO_CONTABIL INT NOT NULL, 
    ID_PROJETO NUMBER(9),
    STATUS CHAR(1) NOT NULL,
    MESANO_INICIO DATE NOT NULL,
    MESANO_FIM DATE NOT NULL,
    DTCRIACAO DATE DEFAULT SYSDATE,
    USCRIACAO VARCHAR2(60),
    DTALTERACAO DATE,
    USALTERACAO VARCHAR2(60)
);

ALTER TABLE SERVDESK.CLASSIF_CONTABIL_PRJ ADD CONSTRAINT FK_CLASSIF_CONTAB_PRJ FOREIGN KEY (ID_CLASSIFICACAO_CONTABIL) REFERENCES CLASSIFICACAO_CONTABIL(ID_CLASSIFICACAO_CONTABIL);

CREATE SEQUENCE  SERVDESK.SEQ_CLASSIF_CONTABIL_PRJ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE;

CREATE OR REPLACE TRIGGER SERVDESK.TGR_CLASSIF_CONTABIL_PRJ_INS 
BEFORE INSERT ON SERVDESK.CLASSIF_CONTABIL_PRJ
FOR EACH ROW
  WHEN (NEW.ID_CLASSIF_CONTABIL_PRJ IS NULL) BEGIN
  SELECT SERVDESK.SEQ_CLASSIF_CONTABIL_PRJ.NEXTVAL
  INTO   :NEW.ID_CLASSIF_CONTABIL_PRJ
  FROM   DUAL;
END;
/