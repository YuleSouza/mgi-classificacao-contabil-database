CREATE TABLE SERVDESK.CLASSIFICACAO_CONTABIL(
    ID_CLASSIFICACAO_CONTABIL INT NOT NULL PRIMARY KEY,
    NOME VARCHAR(200),
    ID_EMPRESA NUMBER(3) NOT NULL, 
    ID_PROJETO NUMBER(9),
    STATUS CHAR(1) NOT NULL,
    MESANO_INICIO DATE NOT NULL,
    MESANO_FIM DATE NOT NULL,
    DTCRIACAO DATE DEFAULT SYSDATE,
    USCRIACAO VARCHAR2(60),
    DTALTERACAO DATE,
    USALTERACAO VARCHAR2(60)
);

CREATE SEQUENCE  SERVDESK.SEQ_CLASSIFICACAO_CONTABIL  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE;

CREATE OR REPLACE TRIGGER SERVDESK.TGR_CLASSIFICACAO_CONTABIL_INS 
BEFORE INSERT ON SERVDESK.CLASSIFICACAO_CONTABIL
FOR EACH ROW
  WHEN (NEW.ID_CLASSIFICACAO_CONTABIL IS NULL) BEGIN
  SELECT SERVDESK.SEQ_CLASSIFICACAO_CONTABIL.NEXTVAL
  INTO   :NEW.ID_CLASSIFICACAO_CONTABIL
  FROM   DUAL;
END;
/

CREATE TABLE SERVDESK.CLASSIFICACAO_ESG(
    ID_CLASSIFICACAO_ESG INT NOT NULL PRIMARY KEY,
    NOME VARCHAR2(100) NOT NULL,
    STATUS CHAR(1) NOT NULL,
    DTCRIACAO DATE DEFAULT SYSDATE,
    USCRIACAO VARCHAR2(60),
    DTALTERACAO DATE,
    USALTERACAO VARCHAR2(60)
);

CREATE SEQUENCE  SERVDESK.SEQ_CLASSIFICACAO_ESG  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE;

CREATE OR REPLACE TRIGGER SERVDESK.TGR_CLASSIFICACAO_ESG_INS 
BEFORE INSERT ON SERVDESK.CLASSIFICACAO_ESG
FOR EACH ROW
  WHEN (NEW.ID_CLASSIFICACAO_ESG IS NULL) BEGIN
  SELECT SERVDESK.SEQ_CLASSIFICACAO_ESG.NEXTVAL
  INTO   :NEW.ID_CLASSIFICACAO_ESG
  FROM   DUAL;
END;
/

CREATE TABLE SERVDESK.CENARIO_CLASSIF_CONTABIL(
    ID_CENARIO_CLASSIF_CONTABIL INT NOT NULL PRIMARY KEY,
    NOME VARCHAR2(100) NOT NULL,
    STATUS CHAR(1) NOT NULL,
    DTCRIACAO DATE DEFAULT SYSDATE,
    USCRIACAO VARCHAR2(60),
    DTALTERACAO DATE,
    USALTERACAO VARCHAR2(60)
);

CREATE SEQUENCE  SERVDESK.SEQ_CENARIO_CLASSIF_CONTABIL  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE;

CREATE OR REPLACE TRIGGER SERVDESK.TGR_CENARIO_CLASSIF_CONT_INS 
BEFORE INSERT ON SERVDESK.CENARIO_CLASSIF_CONTABIL
FOR EACH ROW
  WHEN (NEW.ID_CENARIO_CLASSIF_CONTABIL IS NULL) BEGIN
  SELECT SERVDESK.SEQ_CENARIO_CLASSIF_CONTABIL.NEXTVAL
  INTO   :NEW.ID_CENARIO_CLASSIF_CONTABIL
  FROM   DUAL;
END;
/

CREATE TABLE SERVDESK.PARAMETRIZACAO_CENARIO (
    ID_PARAMETRIZACAO_CENARIO INT NOT NULL PRIMARY KEY,
    ID_CLASSIFICACAO_CONTABIL INT NOT NULL,
    ID_CLASSIFICACAO_ESG INT NOT NULL,
    ID_CENARIO_CLASSIF_CONTABIL INT NOT NULL,
    DTCRIACAO DATE DEFAULT SYSDATE,
    USCRIACAO VARCHAR2(60),
    DTALTERACAO DATE,
    USALTERACAO VARCHAR2(60)
);

ALTER TABLE SERVDESK.PARAMETRIZACAO_CENARIO ADD CONSTRAINT FK_CLASSIF_ESG FOREIGN KEY (ID_CLASSIFICACAO_ESG) REFERENCES CLASSIFICACAO_ESG(ID_CLASSIFICACAO_ESG);
ALTER TABLE SERVDESK.PARAMETRIZACAO_CENARIO ADD CONSTRAINT FK_CENARIO FOREIGN KEY (ID_CENARIO_CLASSIF_CONTABIL) REFERENCES CENARIO_CLASSIF_CONTABIL(ID_CENARIO_CLASSIF_CONTABIL);
CREATE SEQUENCE  SERVDESK.SEQ_PARAMETRIZACAO_CENARIO  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE OR REPLACE TRIGGER SERVDESK.TGR_PARAMETRIZACAO_CENARIO_INS 
BEFORE INSERT ON SERVDESK.PARAMETRIZACAO_CENARIO
FOR EACH ROW
  WHEN (NEW.ID_PARAMETRIZACAO_CENARIO IS NULL) BEGIN
  SELECT SERVDESK.SEQ_PARAMETRIZACAO_CENARIO.NEXTVAL
  INTO   :NEW.ID_PARAMETRIZACAO_CENARIO
  FROM   DUAL;
END;
/


CREATE TABLE SERVDESK.PARAMETRIZACAO_ESG_GERAL (
    ID_PARAM_ESG_GERAL INT NOT NULL PRIMARY KEY,
    ID_GRUPO_PROGRAMA INT NOT NULL,
    DTCRIACAO DATE DEFAULT SYSDATE,
    USCRIACAO VARCHAR2(60),
    DTALTERACAO DATE,
    USALTERACAO VARCHAR2(60)
);

CREATE SEQUENCE  SERVDESK.SEQ_PARAM_ESG_GERAL  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE OR REPLACE TRIGGER SERVDESK.TGR_PARAM_ESG_GERAL_INS 
BEFORE INSERT ON SERVDESK.PARAMETRIZACAO_ESG_GERAL
FOR EACH ROW
  WHEN (NEW.ID_PARAM_ESG_GERAL IS NULL) BEGIN
  SELECT SERVDESK.SEQ_PARAM_ESG_GERAL.NEXTVAL
  INTO   :NEW.ID_PARAM_ESG_GERAL
  FROM   DUAL;
END;
/

CREATE TABLE SERVDESK.PARAMETRIZACAO_ESG_EXC (
    ID_PARAM_ESG_EXC INT NOT NULL PRIMARY KEY, 
    ID_CENARIO_CLASSIF_CONTABIL INT NOT NULL,
    ID_EMPRESA NUMBER(3) NOT NULL, 
    ID_GRUPO_PROGRAMA NUMBER(3) NOT NULL, 
    ID_PROGRAMA NUMBER(3) NOT NULL, 
    ID_PROJETO NUMBER(3) NOT NULL,
    ID_CLASSIFICACAO_ESG INT NOT NULL,
    DTCRIACAO DATE DEFAULT SYSDATE,
    USCRIACAO VARCHAR2(60),
    DTALTERACAO DATE,
    USALTERACAO VARCHAR2(60)
);

ALTER TABLE SERVDESK.PARAMETRIZACAO_ESG_EXC ADD CONSTRAINT FK_PARAM_CLASSIF_ESG FOREIGN KEY (ID_CLASSIFICACAO_ESG) REFERENCES CLASSIFICACAO_ESG(ID_CLASSIFICACAO_ESG);
ALTER TABLE SERVDESK.PARAMETRIZACAO_ESG_EXC ADD CONSTRAINT FK_PARAM_CENARIO FOREIGN KEY (ID_CENARIO_CLASSIF_CONTABIL) REFERENCES CENARIO_CLASSIF_CONTABIL(ID_CENARIO_CLASSIF_CONTABIL);

CREATE SEQUENCE  SERVDESK.SEQ_PARAM_ESG_EXC  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE OR REPLACE TRIGGER SERVDESK.TGR_PARAM_ESG_EXC_INS 
BEFORE INSERT ON SERVDESK.PARAMETRIZACAO_ESG_EXC
FOR EACH ROW
  WHEN (NEW.ID_PARAM_ESG_EXC IS NULL) BEGIN
  SELECT SERVDESK.SEQ_PARAM_ESG_EXC.NEXTVAL
  INTO   :NEW.ID_PARAM_ESG_EXC
  FROM   DUAL;
END;
/