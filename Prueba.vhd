LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Contador IS
    GENERIC (
        Tt : INTEGER := 240000;
        Tt2 : INTEGER := 240000;
        Tt3 : INTEGER := 240000;
        Tt4 : INTEGER := 240000

        --Ta: Integer := 30000
    );
    PORT (
        clk : IN STD_LOGIC;
        PWM1, PWM2, PWM3, PWM4 : OUT STD_LOGIC;
        -- Sensor1, Sensor2, Sensor3 y Push Button
        In1, In2, In3, In4 : IN STD_LOGIC;
        Display : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        Sel : OUT STD_LOGIC_VECTOR(0 TO 2);
        Out1, Out2, Out3, Out4, Out5, LedCP, LedCM, LedCG : OUT STD_LOGIC

    );
END Contador;
ARCHITECTURE Behavioral OF Contador IS

    SIGNAL contador : INTEGER RANGE 0 TO 1800000;
    --------------------------Contador ---------------------------------------
    SIGNAL ObejetoPequeno, ObejetoMediano, ObejetoGrande : INTEGER RANGE 0 TO 9;
    SIGNAL numero : INTEGER RANGE 0 TO 9;
    SIGNAL mul : INTEGER RANGE 0 TO 60000;
    SIGNAL bandera : INTEGER RANGE 0 TO 3;
    ------------- Servos ---------------------
    SIGNAL Cnt : INTEGER RANGE 0 TO Tt;
    SIGNAL Cnt2 : INTEGER RANGE 0 TO Tt2;
    SIGNAL Cnt3 : INTEGER RANGE 0 TO Tt3;
    SIGNAL Cnt4 : INTEGER RANGE 0 TO Tt4;
    SIGNAL Ta : INTEGER RANGE 0 TO Tt; ---- BASE
    SIGNAL Tb : INTEGER RANGE 0 TO Tt2; ------ HOMRBO 
    SIGNAL Tc : INTEGER RANGE 0 TO Tt2; ------ MUÑECA
    SIGNAL Td : INTEGER RANGE 0 TO Tt2; ------ PINZA

    ------------ Logica - Entradas - Salidas --------------------------
    SIGNAL orden, orden2, orden3 : INTEGER RANGE 0 TO 3;
    SIGNAL PushA, PushB, PushC, Inicio : STD_LOGIC;
    SIGNAL retraso : INTEGER RANGE 0 TO 195000000;

BEGIN
    PushA <= In1;
    PushB <= In2;
    PushC <= In3;
    Inicio <= NOT In4;

    PROCESS (clk)
        --variable bandera: integer range 0 to 3;
    BEGIN

        IF rising_edge (clk) THEN
            ---------------------------- Sensar Objeto Pequeño --------------------------------------
            IF (PushA = '1' AND PushB = '0' AND PushC = '0' AND Inicio = '1') THEN
                contador <= contador + 1;
                IF contador = 1800000 THEN
                    orden <= 1;
                    orden2 <= 0;
                    orden3 <= 0;
                    contador <= 0;
                END IF;
            END IF;
            ---------------------------------------- Sensar Objeto Mediano -----------------------------
            IF (PushA = '1' AND PushB = '1' AND PushC = '0' AND Inicio = '1') THEN
                contador <= contador + 1;
                IF contador = 1800000 THEN
                    orden <= 0;
                    orden2 <= 1;
                    contador <= 0;
                END IF;
            END IF;
            ---------------------------------------- Sensar Objeto Grande -----------------------------

            IF (PushA = '1' AND PushB = '1' AND PushC = '1' AND Inicio = '1') THEN
                contador <= contador + 1;
                IF contador = 1800000 THEN
                    orden <= 0;
                    orden2 <= 0;
                    orden3 <= 1;
                    contador <= 0;
                END IF;
            END IF;

            IF orden = 1 OR orden2 = 1 OR orden3 = 1 THEN
                retraso <= retraso + 1;
                Out5 <= '1';
            END IF;

            IF orden = 2 OR orden2 = 2 OR orden3 = 2 THEN
                retraso <= 0;
                Out5 <= '0';
            END IF;

            --------------------------- Pocision Inicial --------------------------------
            IF retraso = 0 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '0';
                LedCP <= '0';
                LedCM <= '0';
                LedCG <= '0';
                Ta <= 9333;
                Tb <= 23333;
                Tc <= 26667;
                Td <= 22000;
            END IF;
            ------------------------ Controlar el Obejeto ObejetoPequenoño ------------------------------------------
            ---------------------- Configuracion - Agarrar Objeto  ------------------------------------------
            --- Bajo
            IF retraso = 15000000 AND orden = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                LedCP <= '1';
                Tc <= 20667;
            END IF;
            -- Bajo
            IF retraso = 30000000 AND orden = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 26000;
            END IF;
            -- Cierro
            IF retraso = 45000000 AND orden = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '1';
                Td <= 24000;
            END IF;
            ---------------------- Configuracion - Subir Objeto - Soltar Objeto ------------------------------------------
            -- Subo
            IF retraso = 60000000 AND orden = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 26667;
            END IF;
            -- Subo
            IF retraso = 75000000 AND orden = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                Tc <= 28000;
            END IF;
            -- Giro
            IF retraso = 90000000 AND orden = 1 THEN
                Out1 <= '1';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '0';
                Ta <= 14000;
            END IF;
            -- Bajo
            IF retraso = 105000000 AND orden = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                Tc <= 23333;
            END IF;
            -- Bajo
            IF retraso = 120000000 AND orden = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 27333;
            END IF;
            -- Abro
            IF retraso = 135000000 AND orden = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '1';
                Td <= 22000;
            END IF;
            -- SUbo
            IF retraso = 150000000 AND orden = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 27333;
            END IF;
            -- Subo
            IF retraso = 165000000 AND orden = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                Tc <= 27333;
            END IF;
            -- Giro
            IF retraso = 180000000 AND orden = 1 THEN
                Out1 <= '1';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '0';
                Ta <= 9333;
            END IF;
            ---------- Final --------------
            IF retraso = 185000000 AND orden = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '0';
                LedCP <= '0';
                orden <= 2;
                ObejetoPequeno <= ObejetoPequeno + 1;
                IF ObejetoPequeno = 9 THEN
                    ObejetoPequeno <= 0;
                END IF;
            END IF;

            ------------------------ Controlar el Obejeto Mediano ------------------------------------------

            ---------------------- Configuracion - Agarrar Objeto  ------------------------------------------
            --- Bajo
            IF retraso = 15000000 AND orden2 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                LedCM <= '1';
                Tc <= 21733;
            END IF;
            -- Bajo
            IF retraso = 30000000 AND orden2 = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 26000;
            END IF;
            -- Cierro
            IF retraso = 45000000 AND orden2 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '1';
                Td <= 24000;
            END IF;
            ---------------------- Configuracion - Subir Objeto - Soltar Objeto ------------------------------------------
            -- Subo
            IF retraso = 60000000 AND orden2 = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 23333;
            END IF;
            -- Subo
            IF retraso = 75000000 AND orden2 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                Tc <= 26000;
            END IF;
            -- Giro
            IF retraso = 90000000 AND orden2 = 1 THEN
                Out1 <= '1';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '0';
                Ta <= 17333;
            END IF;
            -- Bajo
            IF retraso = 105000000 AND orden2 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                Tc <= 23333;
            END IF;
            -- Bajo
            IF retraso = 120000000 AND orden2 = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 23333;
            END IF;
            -- Abro
            IF retraso = 135000000 AND orden2 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '1';
                Td <= 22000;
            END IF;
            -- SUbo
            IF retraso = 150000000 AND orden2 = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 23333;
            END IF;
            -- Subo
            IF retraso = 165000000 AND orden2 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                Tc <= 23333;
            END IF;
            -- Giro
            IF retraso = 180000000 AND orden2 = 1 THEN
                Out1 <= '1';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '0';
                Ta <= 9333;
            END IF;
            ---------- Final --------------
            IF retraso = 185000000 AND orden2 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '0';
                LedCM <= '0';
                orden2 <= 2;
                ObejetoMediano <= ObejetoMediano + 1;
                IF ObejetoMediano = 9 THEN
                    ObejetoMediano <= 0;
                END IF;
            END IF;
            ------------------------ Controlar el Obejeto Grande ------------------------------------------

            ---------------------- Configuracion - Agarrar Objeto  ------------------------------------------
            --- Bajo
            IF retraso = 15000000 AND orden3 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                LedCG <= '1';
                Tc <= 22000;
            END IF;
            -- Bajo
            IF retraso = 30000000 AND orden3 = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 26667;
            END IF;
            -- Cierro
            IF retraso = 45000000 AND orden3 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '1';
                Td <= 24000;
            END IF;
            ---------------------- Configuracion - Subir Objeto - Soltar Objeto ------------------------------------------
            -- Subo
            IF retraso = 60000000 AND orden3 = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 22000;
            END IF;
            -- Subo
            IF retraso = 75000000 AND orden3 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                Tc <= 26000;
            END IF;
            -- Giro
            IF retraso = 90000000 AND orden3 = 1 THEN
                Out1 <= '1';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '0';
                Ta <= 23067;
            END IF;
            -- Bajo
            IF retraso = 105000000 AND orden3 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                Tc <= 20400;
            END IF;
            -- Bajo
            IF retraso = 120000000 AND orden3 = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 22000;
            END IF;
            -- Abro
            IF retraso = 135000000 AND orden3 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '1';
                Td <= 22000;
            END IF;
            -- SUbo
            IF retraso = 150000000 AND orden3 = 1 THEN
                Out1 <= '0';
                Out2 <= '1';
                Out3 <= '0';
                Out4 <= '0';
                Tb <= 23333;
            END IF;
            -- Subo
            IF retraso = 165000000 AND orden3 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '1';
                Out4 <= '0';
                Tc <= 23333;
            END IF;
            -- Giro
            IF retraso = 180000000 AND orden3 = 1 THEN
                Out1 <= '1';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '0';
                Ta <= 9333;
            END IF;
            ---------- Final --------------
            IF retraso = 185000000 AND orden3 = 1 THEN
                Out1 <= '0';
                Out2 <= '0';
                Out3 <= '0';
                Out4 <= '0';
                LedCG <= '0';
                orden3 <= 2;
                ObejetoGrande <= ObejetoGrande + 1;
                IF ObejetoGrande = 9 THEN
                    ObejetoGrande <= 0;
                END IF;
            END IF;
            --------------------------------- Servos -------------------------------------------

            ----------------------------- SERVO 1 --------------------------------
            IF (Cnt = Tt - 1) THEN
                Cnt <= 0;

            ELSE
                Cnt <= Cnt + 1;
            END IF;

            IF (Cnt < Ta) THEN
                PWM1 <= '1';
            ELSE
                PWM1 <= '0';
            END IF;
            ----------------------------- SERVO 2 --------------------------------
            IF (Cnt2 = Tt2 - 1) THEN
                Cnt2 <= 0;

            ELSE
                Cnt2 <= Cnt2 + 1;
            END IF;
            IF (Cnt2 < Tb) THEN
                PWM2 <= '1';
            ELSE
                PWM2 <= '0';
            END IF;
            ----------------------------- SERVO 3 --------------------------------
            IF (Cnt3 = Tt3 - 1) THEN
                Cnt3 <= 0;

            ELSE
                Cnt3 <= Cnt3 + 1;
            END IF;
            IF (Cnt3 < Tc) THEN
                PWM3 <= '1';
            ELSE
                PWM3 <= '0';
            END IF;
            ----------------------------- SERVO 4 --------------------------------
            IF (Cnt4 = Tt4 - 1) THEN
                Cnt4 <= 0;

            ELSE
                Cnt4 <= Cnt4 + 1;
            END IF;
            IF (Cnt4 < Td) THEN
                PWM4 <= '1';
            ELSE
                PWM4 <= '0';
            END IF;

            ----------------------------------------- Contador Display ---------------------------------------

            IF (mul = 60000) THEN
                mul <= 0;
                bandera <= bandera + 1;
                --bandera <= not(bandera);
                IF bandera = 1 THEN
                    numero <= ObejetoPequeno;
                    Sel <= "110";
                END IF;
                IF bandera = 2 THEN
                    numero <= ObejetoMediano;
                    Sel <= "101";
                END IF;
                IF bandera = 3 THEN
                    numero <= ObejetoGrande;
                    Sel <= "011";
                END IF;
            ELSE
                mul <= mul + 1;
            END IF;
            CASE numero IS
                    ---hgfedcba
                WHEN 0 => Display <= "11000000";
                WHEN 1 => Display <= "11111001";
                WHEN 2 => Display <= "10100100";
                WHEN 3 => Display <= "10110000";
                WHEN 4 => Display <= "10011001";
                WHEN 5 => Display <= "10010010";
                WHEN 6 => Display <= "10000010";
                WHEN 7 => Display <= "11111000";
                WHEN 8 => Display <= "10000000";
                WHEN 9 => Display <= "10011000";
                WHEN OTHERS => Display <= "11111111";
            END CASE;
        END IF;

    END PROCESS;
END Behavioral;