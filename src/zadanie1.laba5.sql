CREATE DATABASE svfu_vvs_kva
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE svfu_vvs_ksm 
    IS 'База данных для лабораторной работы по VVS';
