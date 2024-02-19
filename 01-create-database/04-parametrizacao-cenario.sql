CREATE TABLE SERVDESK.PARAMETRIZACAO_CENARIO (
    ID_PARAMETRIZACAO_CENARIO INT NOT NULL PRIMARY KEY,
    ID_CENARIO INT NOT NULL,
    ID_CLASSIFICACAO_CONTABIL INT NOT NULL,
    ID_CLASSIFICACAO INT NOT NULL,
    STATUS CHAR(1) NOT NULL,
    DTCRIACAO DATE DEFAULT SYSDATE,
    USCRIACAO VARCHAR2(60),
    DTALTERACAO DATE,
    USALTERACAO VARCHAR2(60)
);

ALTER TABLE SERVDESK.PARAMETRIZACAO_CENARIO ADD CONSTRAINT FK_CENARIO FOREIGN KEY (ID_CENARIO) REFERENCES CENARIO(ID_CENARIO);
ALTER TABLE SERVDESK.PARAMETRIZACAO_CENARIO ADD CONSTRAINT FK_CLASSIF_CONTAB FOREIGN KEY (ID_CLASSIFICACAO_CONTABIL) REFERENCES CLASSIFICACAO_CONTABIL(ID_CLASSIFICACAO_CONTABIL);
ALTER TABLE SERVDESK.PARAMETRIZACAO_CENARIO ADD CONSTRAINT FK_CLASSIF FOREIGN KEY (ID_CLASSIFICACAO) REFERENCES CLASSIFICACAO(ID_CLASSIFICACAO);
CREATE INDEX SERVDESK.IDX_PARAMETRIZACAO_CENARIO ON PARAMETRIZACAO_CENARIO (ID_PARAMETRIZACAO_CENARIO);

CREATE SEQUENCE  SERVDESK.SEQ_PARAMETRIZACAO_CENARIO  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE OR REPLACE TRIGGER SERVDESK.TGR_PARAMETRIZACAO_CENARIO_INS 
BEFORE INSERT ON SERVDESK.PARAMETRIZACAO_CENARIO
FOR EACH ROW
  WHEN (NEW.ID_LANCAMENTO IS NULL) BEGIN
  SELECT SERVDESK.SEQ_PARAMETRIZACAO_CENARIO.NEXTVAL
  INTO   :NEW.ID_LANCAMENTO
  FROM   DUAL;
END;
/