/******************************************************************************/
/***          Generated by IBExpert 2012.02.21 09/11/2015 14:59:09          ***/
/******************************************************************************/

SET SQL DIALECT 3;

SET NAMES UTF8;

SET CLIENTLIB 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll';

CREATE DATABASE 'C:\Users\paulo\Dropbox\Projeto_ERP\ERP.fdb'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 4096
DEFAULT CHARACTER SET UTF8 COLLATION UTF8;



/******************************************************************************/
/***                               Generators                               ***/
/******************************************************************************/

CREATE GENERATOR GEN_CONDICAOPAGAMENTO_ID;
SET GENERATOR GEN_CONDICAOPAGAMENTO_ID TO 0;

CREATE GENERATOR GEN_CONTABANCARIA_ID;
SET GENERATOR GEN_CONTABANCARIA_ID TO 0;

CREATE GENERATOR GEN_EMPRESA_ID;
SET GENERATOR GEN_EMPRESA_ID TO 0;

CREATE GENERATOR GEN_PESSOAS_ID;
SET GENERATOR GEN_PESSOAS_ID TO 0;

CREATE GENERATOR GEN_TIPOPAGAMENTO_ID;
SET GENERATOR GEN_TIPOPAGAMENTO_ID TO 0;

CREATE GENERATOR GEN_TITULOSP_ID;
SET GENERATOR GEN_TITULOSP_ID TO 0;

CREATE GENERATOR GEN_TITULO_RECEBER_ID;
SET GENERATOR GEN_TITULO_RECEBER_ID TO 0;



/******************************************************************************/
/***                                 Tables                                 ***/
/******************************************************************************/



CREATE TABLE BANCO (
    BAN_CODIGO     INTEGER NOT NULL,
    BAN_DESCRICAO  VARCHAR(100)
);

CREATE TABLE CONDICAOPAGAMENTO (
    CDP_CODIGO           INTEGER NOT NULL,
    CDP_DESCRICAO        VARCHAR(100),
    CDP_PARCELAS         INTEGER,
    CDP_DIAS_VENCIMENTO  INTEGER
);

CREATE TABLE CONTABANCARIA (
    CTB_CODIGO      INTEGER NOT NULL,
    CTB_EMP_CODIGO  INTEGER,
    CTB_BAN_CODIGO  INTEGER,
    CTB_CONTA       NUMERIC(15,2),
    CTB_OPERACAO    NUMERIC(10,2),
    CTB_AGENCIA     NUMERIC(10,2)
);

CREATE TABLE TIPOPAGAMENTO (
    TPG_CODIGO     INTEGER NOT NULL,
    TPG_DESCRICAO  VARCHAR(100)
);

CREATE TABLE TITULO_RECEBER (
    TTR_CODIGO           INTEGER NOT NULL,
    TTR_EMP_CODIGO       INTEGER NOT NULL,
    TTR_PES_CODIGO       INTEGER,
    TTR_CTB_CODIGO       INTEGER,
    TTR_CON_CODIGO       INTEGER,
    TTR_DESCRICAO        VARCHAR(100),
    TTR_DT_EMISSAO       DATE,
    TTR_DT_VENCIMENTO    DATE,
    TTR_DT_PAGAMENTO     DATE,
    TTR_DT_BAIXA         DATE,
    TTR_DT_CANCELAMENTO  DATE,
    TTR_TP_TITULO        VARCHAR(30),
    TTR_DESCONTO         NUMERIC(18,2),
    TTR_PARCELA          NUMERIC(10,2),
    TTR_VL_ORIGINAL      NUMERIC(18,2),
    TTR_VL_PAGO          NUMERIC(18,2),
    TTR_VL_TOTAL         NUMERIC(18,2),
    TTR_MR_DIARIA        NUMERIC(18,2),
    TTR_MT_ATRASO        NUMERIC(18,2),
    TTR_SITUACAO         VARCHAR(1) DEFAULT 'A',
    TTR_TP_MORA          VARCHAR(1) DEFAULT 'P',
    TTR_TP_MULTA         VARCHAR(1) DEFAULT 'P'
);

CREATE TABLE TITULOSP (
    TTP_CODIGO           INTEGER NOT NULL,
    TTP_EMP_CODIGO       INTEGER NOT NULL,
    TTP_PES_CODIGO       INTEGER,
    TTP_CTB_CODIGO       INTEGER,
    TTP_CON_CODIGO       INTEGER,
    TTP_DESCRICAO        VARCHAR(100),
    TTP_DT_EMISSAO       DATE,
    TTP_DT_VENCIMENTO    DATE,
    TTP_DT_PAGAMENTO     DATE,
    TTP_DT_BAIXA         DATE,
    TTP_DT_CANCELAMENTO  DATE,
    TTP_TP_TITULO        VARCHAR(30),
    TTP_DESCONTO         NUMERIC(18,2),
    TTP_PARCELA          NUMERIC(10,2),
    TTP_VL_ORIGINAL      NUMERIC(18,2),
    TTP_VL_PAGO          NUMERIC(18,2),
    TTP_VL_TOTAL         NUMERIC(18,2),
    TTP_MR_DIARIA        NUMERIC(18,2),
    TTP_MT_ATRASO        NUMERIC(18,2),
    TTP_SITUACAO         VARCHAR(1) DEFAULT 'A',
    TTP_TP_MORA          VARCHAR(1) DEFAULT 'P',
    TTP_TP_MULTA         VARCHAR(1) DEFAULT 'P'
);



/******************************************************************************/
/***                              Primary Keys                              ***/
/******************************************************************************/

ALTER TABLE BANCO ADD CONSTRAINT PK_BANCO PRIMARY KEY (BAN_CODIGO);
ALTER TABLE CONDICAOPAGAMENTO ADD CONSTRAINT PK_CONDICAOPAGAMENTO PRIMARY KEY (CDP_CODIGO);
ALTER TABLE CONTABANCARIA ADD CONSTRAINT PK_CONTABANCARIA PRIMARY KEY (CTB_CODIGO);
ALTER TABLE TIPOPAGAMENTO ADD CONSTRAINT PK_TIPOPAGAMENTO PRIMARY KEY (TPG_CODIGO);
ALTER TABLE TITULOSP ADD CONSTRAINT PK_TITULOSP PRIMARY KEY (TTP_CODIGO, TTP_EMP_CODIGO);
ALTER TABLE TITULO_RECEBER ADD CONSTRAINT PK_TITULO_RECEBER PRIMARY KEY (TTR_CODIGO, TTR_EMP_CODIGO);


/******************************************************************************/
/***                              Foreign Keys                              ***/
/******************************************************************************/

ALTER TABLE CONTABANCARIA ADD CONSTRAINT REL_CTB_BANCO FOREIGN KEY (CTB_BAN_CODIGO) REFERENCES BANCO (BAN_CODIGO);
ALTER TABLE CONTABANCARIA ADD CONSTRAINT REL_CTB_EMPRESA FOREIGN KEY (CTB_EMP_CODIGO) REFERENCES EMPRESA (COD_EMPRESA);
ALTER TABLE TITULOSP ADD CONSTRAINT REL_TTP_CONDICAO FOREIGN KEY (TTP_CON_CODIGO) REFERENCES CONDICAOPAGAMENTO (CDP_CODIGO);
ALTER TABLE TITULOSP ADD CONSTRAINT REL_TTP_CONTAB FOREIGN KEY (TTP_CTB_CODIGO) REFERENCES CONTABANCARIA (CTB_CODIGO);
ALTER TABLE TITULOSP ADD CONSTRAINT REL_TTP_EMPRESA FOREIGN KEY (TTP_EMP_CODIGO) REFERENCES EMPRESA (COD_EMPRESA);
ALTER TABLE TITULOSP ADD CONSTRAINT REL_TTP_PESSOA FOREIGN KEY (TTP_PES_CODIGO) REFERENCES PESSOAS (PESS_CODIGO);
ALTER TABLE TITULO_RECEBER ADD CONSTRAINT REL_TTR_CONDICAO FOREIGN KEY (TTR_CON_CODIGO) REFERENCES CONDICAOPAGAMENTO (CDP_CODIGO);
ALTER TABLE TITULO_RECEBER ADD CONSTRAINT REL_TTR_CONTAB FOREIGN KEY (TTR_CTB_CODIGO) REFERENCES CONTABANCARIA (CTB_CODIGO);
ALTER TABLE TITULO_RECEBER ADD CONSTRAINT REL_TTR_EMPRESA FOREIGN KEY (TTR_EMP_CODIGO) REFERENCES EMPRESA (COD_EMPRESA);
ALTER TABLE TITULO_RECEBER ADD CONSTRAINT REL_TTR_PESSOA FOREIGN KEY (TTR_PES_CODIGO) REFERENCES PESSOAS (PESS_CODIGO);


/******************************************************************************/
/***                                Triggers                                ***/
/******************************************************************************/


SET TERM ^ ;



/******************************************************************************/
/***                          Triggers for tables                           ***/
/******************************************************************************/



/* Trigger: CONDICAOPAGAMENTO_BI */
CREATE TRIGGER CONDICAOPAGAMENTO_BI FOR CONDICAOPAGAMENTO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.cdp_codigo is null) then
    new.cdp_codigo = gen_id(gen_condicaopagamento_id,1);
end
^

/* Trigger: CONTABANCARIA_BI */
CREATE TRIGGER CONTABANCARIA_BI FOR CONTABANCARIA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.ctb_codigo is null) then
    new.ctb_codigo = gen_id(gen_contabancaria_id,1);
end
^

/* Trigger: EMPRESA_BI */
CREATE TRIGGER EMPRESA_BI FOR EMPRESA
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.cod_empresa is null) then
    new.cod_empresa = gen_id(gen_empresa_id,1);
end
^

/* Trigger: PESSOAS_BI */
CREATE TRIGGER PESSOAS_BI FOR PESSOAS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.pess_codigo is null) then
    new.pess_codigo = gen_id(gen_pessoas_id,1);
end
^

/* Trigger: TIPOPAGAMENTO_BI */
CREATE TRIGGER TIPOPAGAMENTO_BI FOR TIPOPAGAMENTO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.tpg_codigo is null) then
    new.tpg_codigo = gen_id(gen_tipopagamento_id,1);
end
^

/* Trigger: TITULOSP_BI */
CREATE TRIGGER TITULOSP_BI FOR TITULOSP
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.ttp_codigo is null) then
    new.ttp_codigo = gen_id(gen_titulosp_id,1);
end
^

/* Trigger: TITULO_RECEBER_BI */
CREATE TRIGGER TITULO_RECEBER_BI FOR TITULO_RECEBER
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.ttr_codigo is null) then
    new.ttr_codigo = gen_id(gen_titulo_receber_id,1);
end
^

SET TERM ; ^
