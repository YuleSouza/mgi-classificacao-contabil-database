CREATE TABLE SERVDESK.PARAMETRIZACAO_ESG_EXCESSAO (
    ID_PARAMETRIZACAO_ESG_EXCESSAO INT NOT NULL PRIMARY KEY, 
    ID_CENARIO INT NOT NULL,
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

ALTER TABLE SERVDESK.PARAMETRIZACAO_CENARIO ADD CONSTRAINT FK_CLASSIF_ESG FOREIGN KEY (ID_CLASSIFICACAO_ESG) REFERENCES CLASSIFICACAO_ESG(ID_CLASSIFICACAO_ESG);
ALTER TABLE SERVDESK.PARAMETRIZACAO_CENARIO ADD CONSTRAINT FK_CENARIO FOREIGN KEY (ID_CENARIO) REFERENCES CENARIO(ID_CENARIO);

CREATE INDEX SERVDESK.IDX_PARAMETRIZACAO_ESG_EXCESSAO ON PARAMETRIZACAO_ESG_EXCESSAO (ID_PARAMETRIZACAO_ESG_EXCESSAO);
CREATE SEQUENCE  SERVDESK.SEQ_PARAMETRIZACAO_ESG_EXCESSAO  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE OR REPLACE TRIGGER SERVDESK.TGR_PARAMETRIZACAO_ESG_EXCESSAO_INS 
BEFORE INSERT ON SERVDESK.PARAMETRIZACAO_ESG_EXCESSAO
FOR EACH ROW
  WHEN (NEW.ID_LANCAMENTO IS NULL) BEGIN
  SELECT SERVDESK.SEQ_PARAMETRIZACAO_ESG_EXCESSAO.NEXTVAL
  INTO   :NEW.ID_LANCAMENTO
  FROM   DUAL;
END;
/