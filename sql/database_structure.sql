grant connect on database :: HouseholdManagement to dbo
go

grant view any column encryption key definition, view any column master key definition on database :: HouseholdManagement to [public]
go

create table RegistrationStatuses
(
    StatusID    int identity
        primary key,
    StatusName  varchar(20) not null
        unique,
    Description nvarchar(255)
)
go

create table RegistrationTypes
(
    RegistrationTypeID int identity
        primary key,
    TypeName           varchar(100) not null
        unique,
    Description        nvarchar(255)
)
go

create table Roles
(
    RoleID      int identity
        primary key,
    RoleName    varchar(20) not null
        unique,
    Description nvarchar(255)
)
go

create table Users
(
    UserID            int identity
        primary key,
    FullName          nvarchar(100) not null,
    Email             varchar(100)  not null
        unique,
    Password          varchar(255)  not null,
    RoleID            int           not null
        references Roles,
    Address           nvarchar(255) not null,
    CCCD              varchar(12)   not null
        unique,
    remember_me_token varchar(255),
    HouseholdID       int,
    Gender            nvarchar(10)
        constraint CK_Users_Gender
            check ([Gender] = 'Other' OR [Gender] = 'Female' OR [Gender] = 'Male'),
    PhoneNumber       varchar(15)
)
go

exec sp_addextendedproperty 'MS_Description', 'User gender (Male, Female, Other)', 'SCHEMA', 'dbo', 'TABLE', 'Users',
     'COLUMN', 'Gender'
go

exec sp_addextendedproperty 'MS_Description', 'User phone number', 'SCHEMA', 'dbo', 'TABLE', 'Users', 'COLUMN',
     'PhoneNumber'
go

create table Logs
(
    LogID     int identity
        primary key,
    UserID    int
        references Users
            on delete cascade,
    Action    nvarchar(100) not null,
    Timestamp datetime default getdate()
)
go

create table Notifications
(
    NotificationID int identity
        primary key,
    UserID         int
        references Users
            on delete cascade,
    Message        nvarchar(500) not null,
    SentDate       datetime default getdate(),
    IsRead         bit      default 0
)
go

create table UserAvatars
(
    AvatarID   int identity
        primary key,
    UserID     int                        not null
        references Users
            on delete cascade,
    AvatarPath varchar(255)               not null,
    UploadDate datetime default getdate() not null,
    IsActive   bit      default 1         not null
)
go

create trigger trg_DeleteUserRegistrations
    on Users
    for delete
    as
-- missing source code
go

create table administrative_regions
(
    id           int           not null
        constraint administrative_regions_pkey
            primary key,
    name         nvarchar(255) not null,
    name_en      nvarchar(255) not null,
    code_name    nvarchar(255),
    code_name_en nvarchar(255)
)
go

create table administrative_units
(
    id            int not null
        constraint administrative_units_pkey
            primary key,
    full_name     nvarchar(255),
    full_name_en  nvarchar(255),
    short_name    nvarchar(255),
    short_name_en nvarchar(255),
    code_name     nvarchar(255),
    code_name_en  nvarchar(255)
)
go

create table provinces
(
    code                     nvarchar(20)  not null
        constraint provinces_pkey
            primary key,
    name                     nvarchar(255) not null,
    name_en                  nvarchar(255),
    full_name                nvarchar(255) not null,
    full_name_en             nvarchar(255),
    code_name                nvarchar(255),
    administrative_unit_id   int
        constraint provinces_administrative_unit_id_fkey
            references administrative_units,
    administrative_region_id int
        constraint provinces_administrative_region_id_fkey
            references administrative_regions
)
go

create table districts
(
    code                   nvarchar(20)  not null
        constraint districts_pkey
            primary key,
    name                   nvarchar(255) not null,
    name_en                nvarchar(255),
    full_name              nvarchar(255),
    full_name_en           nvarchar(255),
    code_name              nvarchar(255),
    province_code          nvarchar(20)
        constraint districts_province_code_fkey
            references provinces,
    administrative_unit_id int
        constraint districts_administrative_unit_id_fkey
            references administrative_units
)
go

create index idx_districts_province
    on districts (province_code)
go

create index idx_districts_unit
    on districts (administrative_unit_id)
go

create index idx_provinces_region
    on provinces (administrative_region_id)
go

create index idx_provinces_unit
    on provinces (administrative_unit_id)
go

create table wards
(
    code                   nvarchar(20)  not null
        constraint wards_pkey
            primary key,
    name                   nvarchar(255) not null,
    name_en                nvarchar(255),
    full_name              nvarchar(255),
    full_name_en           nvarchar(255),
    code_name              nvarchar(255),
    district_code          nvarchar(20)
        constraint wards_district_code_fkey
            references districts,
    administrative_unit_id int
        constraint wards_administrative_unit_id_fkey
            references administrative_units
)
go

create table Areas
(
    AreaID          int identity
        constraint PK_Areas
            primary key,
    ProvinceCode    nvarchar(20) not null
        constraint FK_Areas_Provinces
            references provinces,
    DistrictCode    nvarchar(20) not null
        constraint FK_Areas_Districts
            references districts,
    WardCode        nvarchar(20) not null
        constraint FK_Areas_Wards
            references wards,
    AreaLeaderID    int,
    PoliceOfficerID int
)
go

create index IX_Areas_ProvinceCode
    on Areas (ProvinceCode)
go

create index IX_Areas_DistrictCode
    on Areas (DistrictCode)
go

create index IX_Areas_WardCode
    on Areas (WardCode)
go

create index IX_Areas_AreaLeaderID
    on Areas (AreaLeaderID)
go

create index IX_Areas_PoliceOfficerID
    on Areas (PoliceOfficerID)
go

create table Households
(
    HouseholdID       int identity
        primary key,
    HeadOfHouseholdID int
        constraint FK_Households_Users
            references Users
        references Users,
    Address           nvarchar(255) not null,
    CreatedDate       datetime
        constraint DF_Households_CreatedDate default getdate(),
    AreaID            int
        constraint FK_Households_Areas
            references Areas
)
go

create table HouseholdMembers
(
    MemberID     int identity
        primary key,
    HouseholdID  int           not null
        constraint FK_HouseholdMembers_Households
            references Households,
    FullName     nvarchar(100) not null,
    Relationship nvarchar(50)  not null,
    DateOfBirth  datetime,
    Gender       nvarchar(10),
    PhoneNumber  nvarchar(20),
    Email        nvarchar(100),
    CCCD         nvarchar(20),
    CreatedDate  datetime default getdate()
)
go

create index IX_Households_AreaID
    on Households (AreaID)
go

create table Registrations
(
    RegistrationID       int identity
        primary key,
    UserID               int,
    HouseholdID          int
        constraint FK_Registrat_House_4A8B1AF0
            references Households
            on delete cascade,
    RegistrationTypeID   int
        references RegistrationTypes,
    SentDate             date          not null,
    Reason               nvarchar(500),
    RegistrationStatusID int default 1 not null
)
go

create table AddMemberRegistrations
(
    AddMemberRegistrationID int identity
        primary key,
    RegistrationID          int           not null
        references Registrations
            on delete cascade,
    FullName                nvarchar(100) not null,
    DateOfBirth             date,
    Gender                  varchar(10),
    IdNumber                varchar(20),
    PhoneNumber             varchar(20),
    Relationship            nvarchar(50)  not null,
    ReasonForAddition       nvarchar(500) not null,
    PreviousHouseholdID     int,
    HeadOfHouseholdConsent  bit default 0 not null
)
go

create table RegistrationDocuments
(
    DocumentID     int identity
        primary key,
    RegistrationID int                        not null
        references Registrations
            on delete cascade,
    DocumentType   nvarchar(50)               not null,
    FilePath       nvarchar(255)              not null,
    FileName       nvarchar(100)              not null,
    FileSize       int                        not null,
    ContentType    nvarchar(100)              not null,
    UploadDate     datetime default getdate() not null,
    Description    nvarchar(255),
    FileData       varbinary(max)
)
go

create table RegistrationVerifications
(
    VerificationID       int identity
        primary key,
    RegistrationID       int           not null
        references Registrations
            on delete cascade,
    VerificationUserID   int
        constraint RegistrationVerifications_Users__fk
            references Users,
    VerificationDate     date,
    VerifierComments     nvarchar(500),
    VerificationStatusID int default 1 not null
        references RegistrationStatuses
)
go

create trigger trg_UpdateRegistrationStatus
    on RegistrationVerifications
    for insert, update
    as
-- missing source code
go

create trigger trg_ValidateVerifierRole
    on RegistrationVerifications
    for insert, update
    as
-- missing source code
go

CREATE TRIGGER trg_DeleteRegistrationCascade
    ON Registrations
    AFTER DELETE
    AS
BEGIN
    -- Delete related records in TransferRegistrations
    DELETE FROM TransferRegistrations
    WHERE RegistrationID IN (SELECT RegistrationID FROM deleted);

    -- Delete related records in SplitRegistrationMembers
    DELETE FROM SplitRegistrations
    WHERE RegistrationID IN (SELECT RegistrationID FROM deleted);

    -- Delete related records in RegistrationDocuments
    DELETE FROM RegistrationDocuments
    WHERE RegistrationID IN (SELECT RegistrationID FROM deleted);
END;
go

create table SplitRegistrations
(
    SplitRegistrationID    int identity
        primary key,
    RegistrationID         int           not null
        constraint SplitRegistrations_Registrations__fk
            references Registrations
            on delete cascade,
    ReasonForSplit         nvarchar(500) not null,
    NewAddress             nvarchar(255) not null,
    NewWardCode            varchar(20)   not null,
    NewDistrictCode        varchar(20)   not null,
    NewProvinceCode        varchar(20)   not null,
    HeadOfHouseholdConsent bit default 0 not null
)
go

create table TransferRegistrations
(
    TransferRegistrationID int identity
        primary key,
    RegistrationID         int           not null
        references Registrations
            on delete cascade,
    NewAddress             nvarchar(255) not null,
    NewWardCode            varchar(20)   not null,
    NewDistrictCode        varchar(20)   not null,
    NewProvinceCode        varchar(20)   not null,
    PreviousAddress        nvarchar(255),
    ReasonForTransfer      nvarchar(500) not null,
    HeadOfHouseholdConsent bit default 0 not null,
    MoveDate               date          not null
)
go

create index idx_wards_district
    on wards (district_code)
go

create index idx_wards_unit
    on wards (administrative_unit_id)
go

use AppointmentManagement
go

grant connect on database :: AppointmentManagement to []
go

grant view any column encryption key definition, view any column master key definition on database :: AppointmentManagement to []
go

use master
go

grant administer bulk operations, alter any availability group, alter any connection, alter any credential, alter any database, alter any endpoint, alter any event notification, alter any event session, alter any event session add event,
alter any event session add target, alter any event session disable, alter any event session drop
event, connect sql, control server, create any database, create any event session, create availability group,
create ddl event notification, create endpoint, create login, create server role,
create trace event notification, drop any event session, external access assembly, impersonate any login,
select all user securables, shutdown, unsafe assembly, view any cryptographically secured definition, view any database, view any definition, view any error log, view any performance definition, view any security definition, view server performance state, view server security audit, view server security state, view server state to ##MS_AgentSigningCertificate##
go

use AppointmentManagement
go

use master
go

grant connect sql to ##MS_PolicyEventProcessingLogin##
go

use AppointmentManagement
go

use master
go

grant control server, view any definition to ##MS_PolicySigningCertificate##
go

use AppointmentManagement
go

use master
go

grant connect sql, view any definition, view server state to ##MS_PolicyTsqlExecutionLogin##
go

use AppointmentManagement
go

use master
go

grant authenticate server to ##MS_SQLAuthenticatorCertificate##
go

use AppointmentManagement
go

use master
go

grant authenticate server, view any definition, view server state to ##MS_SQLReplicationSigningCertificate##
go

use AppointmentManagement
go

use master
go

grant view any definition to ##MS_SQLResourceSigningCertificate##
go

use AppointmentManagement
go

use master
go

grant view any definition to ##MS_SmoExtendedSigningCertificate##
go

use AppointmentManagement
go

use master
go

grant connect sql to [KHOA\quang]
go

use AppointmentManagement
go

use master
go

grant alter any availability group, connect sql, view server state to [NT AUTHORITY\SYSTEM]
go

use AppointmentManagement
go

use master
go

grant connect sql to [NT SERVICE\SQLSERVERAGENT]
go

use AppointmentManagement
go

use master
go

grant alter any event session, connect any database, connect sql, view any definition, view server state to [NT SERVICE\SQLTELEMETRY]
go

use AppointmentManagement
go

use master
go

grant connect sql to [NT SERVICE\SQLWriter]
go

use AppointmentManagement
go

use master
go

grant connect sql to [NT SERVICE\Winmgmt]
go

use AppointmentManagement
go

use master
go

grant connect sql to [NT Service\MSSQLSERVER]
go

use AppointmentManagement
go

use master
go

grant view any database to [public]
go

use AppointmentManagement
go

use master
go

grant connect sql to sa
go

use AppointmentManagement
go