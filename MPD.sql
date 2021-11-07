# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #
# ---------------------------------------------------------------------- #
# Add table "Categories"                                                 #
# ---------------------------------------------------------------------- #

CREATE TABLE Categorie (
    CodeCateg INT NOT NULL AUTO_INCREMENT,
    NomCateg VARCHAR(15) NOT NULL,
    Descriptionn VARCHAR(255),
     CONSTRAINT `PK_Categories` PRIMARY KEY (CodeCateg)
   )ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX NomCateg ON `Categorie` (`NomCateg`);
# ---------------------------------------------------------------------- #
# Add table "Clientt"                                                  #
# ---------------------------------------------------------------------- #
CREATE TABLE Clientt (
    Codecli VARCHAR(5) NOT NULL,
    Societe VARCHAR(45) NOT NULL,
    Contact VARCHAR(45) NOT NULL,
    Fonction VARCHAR(45) NOT NULL,
    Adresse VARCHAR(45),
    Ville VARCHAR(25) ,
    Region VARCHAR(25),
    Codepostal VARCHAR(10),
    Pays VARCHAR(25) ,
    Tel VARCHAR(25) ,
    Fax VARCHAR(25),
	CONSTRAINT `PK_Clientt` PRIMARY KEY (Codecli)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX `Ville` ON `Clientt` (`Ville`);

CREATE INDEX `Societe` ON `Clientt` (`Societe`);

CREATE INDEX `Codepostal` ON `Clientt` (`Codepostal`);

CREATE INDEX `Region` ON `Clientt` (`Region`);

# ---------------------------------------------------------------------- #
# Add table "Employees"                                                  #
# ---------------------------------------------------------------------- #

CREATE TABLE `Employe` (
    NoEmp INT NOT NULL AUTO_INCREMENT,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    Fonction VARCHAR(50) ,
    TitreCourtoisie VARCHAR(50),
    DateNaissance DATETIME,
    DateEmbauche DATETIME ,
    Adresse VARCHAR(60),
    Ville VARCHAR(50),
    Region VARCHAR(50),
    Codepostal VARCHAR(50) ,
    Pays VARCHAR(50) ,
    TelDom VARCHAR(20) ,
    Extension VARCHAR(50),
    RendCompteA INT, 
    -- REFERENCES employe(NoEmp),--
    CONSTRAINT `PK_Employe` PRIMARY KEY (NoEmp)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX `Nom` ON `Employe` (`Nom`);

CREATE INDEX `Codepostal` ON `Employe` (`Codepostal`);

# ---------------------------------------------------------------------- #
# Add table "DetailsCommande"                                              #
# ---------------------------------------------------------------------- #

CREATE TABLE DetailsCommande (
    NoCom INT NOT NULL,
    RefProd INT NOT NULL,
    PrixUnit DECIMAL(10,4) NOT NULL DEFAULT 0,
    Qte INT NOT NULL DEFAULT 1,
    Remise Double NOT NULL DEFAULT 0,
    CONSTRAINT `PK_DetailsCommande` PRIMARY KEY (NoCom , RefProd)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
# ---------------------------------------------------------------------- #
# Add table "Commande"                                                     #
# ---------------------------------------------------------------------- #
CREATE TABLE Commande (
    NoCom INT NOT NULL AUTO_INCREMENT,
    CodeCli VARCHAR(10) ,
    NoEmp INT,
    DateCom DATETIME ,
    ALivAvant DATETIME,
    DateEnv DATETIME,
    NoMess INT ,
    Portt DECIMAL(10,4) DEFAULT 0,
    Destinataire VARCHAR(50) ,
    AdrLiv VARCHAR(50) ,
    VilleLiv VARCHAR(50) ,
    RegionLiv VARCHAR(50),
    CodePostalLiv VARCHAR(20),
    PaysLiv VARCHAR(25) ,
    PRIMARY KEY (NoCom)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE INDEX `DateCom` ON `Commande` (`DateCom`);

CREATE INDEX `DateEnv` ON `Commande` (`DateEnv`);

CREATE INDEX `CodePostalLiv` ON `Commande` (`CodePostalLiv`);

# ---------------------------------------------------------------------- #
# Add table "Products"                                                   #
# ---------------------------------------------------------------------- #

CREATE TABLE Produit (
    RefProd INT NOT NULL AUTO_INCREMENT,
    NomProd VARCHAR(50) NOT NULL,
    NoFour INT ,
    CodeCateg INT,
    QteParUnit VARCHAR(20) ,
    PrixUnit DECIMAL(10,4) default 0,
    UnitesStock SMALLINT DEFAULT 0,
    UnitesCom SMALLINT DEFAULT 0,
    NiveauReap SMALLINT DEFAULT 0,
    Indisponible BIT NOT NULL default 0,
    CONSTRAINT `PK_Produit` PRIMARY KEY (RefProd)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX `NomProd` ON `Produit` (`NomProd`);

# ---------------------------------------------------------------------- #
# Add table "Shippers"                                                   #
# ---------------------------------------------------------------------- #

CREATE TABLE Messager (
    NoMess INT NOT NULL AUTO_INCREMENT,
    NomMess VARCHAR(50) NOT NULL,
    Tel VARCHAR(20),
    CONSTRAINT `PK_Shippers` PRIMARY KEY (NoMess)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# ---------------------------------------------------------------------- #
# Add table "Fournisseur"                                                  #
# ---------------------------------------------------------------------- #

CREATE TABLE Fournisseur (
    NoFour INT NOT NULL AUTO_INCREMENT,
    Societe VARCHAR(45) NOT NULL,
    Contact VARCHAR(45) ,
    Fonction VARCHAR(45) ,
    Adresse VARCHAR(255) ,
    Ville VARCHAR(45),
    Region VARCHAR(45),
    CodePostal VARCHAR(10) ,
    Pays VARCHAR(45) ,
    Tel VARCHAR(20) ,
    Fax VARCHAR(20),
    PageAccueil MEDIUMTEXT,
    CONSTRAINT `PK_Fournisseur` PRIMARY KEY (NoFour)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX `Societe` ON `Fournisseur` (`Societe`);

CREATE INDEX `CodePostal` ON `Fournisseur` (`CodePostal`);
