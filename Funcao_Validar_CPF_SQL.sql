DELIMITER $

#11144477705
#52998224725


CREATE FUNCTION validar_CPF(cpf CHAR(11)) RETURNS VARCHAR(12) DETERMINISTIC
BEGIN
    DECLARE soma INT;
    DECLARE indice INT;
    DECLARE digito_1 INT;
    DECLARE digito_2 INT;
    DECLARE digito_1_cpf CHAR(2);
    DECLARE digito_2_cpf CHAR(2);

    SET cpf = TRIM(cpf); /* Retirando possíveis espaços do lado direito e esquerdo do CPF inserido */
    
    /* Verificando se todos os números do cpf são iguais */
    IF (cpf IN ('00000000000', '11111111111', '22222222222', '33333333333', '44444444444', '55555555555', '66666666666', '77777777777', '88888888888', '99999999999', '12345678909')) THEN
      RETURN FALSE;
    END IF;
    
    IF (LENGTH(cpf) != 11) THEN /* Se o cpf tiver menos ou mais que 11 caracteres, ele será retornado como inválido*/
        RETURN "CPF INVÁLIDO";
    ELSE 

   SET digito_1_cpf = SUBSTRING(cpf, 10, 1);
   SET digito_2_cpf = SUBSTRING(cpf, 11, 1);

        SET soma = 0;
        SET indice = 1;
        WHILE (indice <= 9) DO          
            SET soma = soma + CAST(SUBSTRING(cpf,indice,1) AS UNSIGNED) * (11 - indice);
            SET indice = indice + 1;      
         END WHILE;
         
         SET digito_1 = 11 - (soma % 11);     
         
         IF (digito_1 > 9) THEN
            SET digito_1 = 0;
         END IF;
         
        SET soma = 0;
        SET indice = 1;
        
        WHILE (indice <= 10) DO
             SET soma = soma + CAST(SUBSTRING(cpf,indice,1) AS UNSIGNED) * (12 - indice);              
             SET indice = indice + 1;
        END WHILE;
        
        SET digito_2 = 11 - (soma % 11);
        
        IF digito_2 > 9 THEN
            SET digito_2 = 0;
        END IF;

        IF (digito_1 = digito_1_cpf) AND (digito_2 = digito_2_CPF) THEN
            RETURN "CPF VÁLIDO";
        ELSE
            RETURN "CPF INVÁLIDO";
        END IF;
 END IF;
END;
$

## Fazendo a consulta do cpf:
SELECT validar_CPF(11144477705);