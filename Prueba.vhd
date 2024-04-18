LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Contador IS

	PORT (
		clk : IN STD_LOGIC;
		--pwm: out std_logic;
		In1, In2, In3, In4 : IN STD_LOGIC;
		Out1, Out2, Out3, Out4 : OUT STD_LOGIC

	);
END Contador;
ARCHITECTURE Behavioral OF Contador IS

	SIGNAL numero : INTEGER RANGE 0 TO 9;
	SIGNAL contador : INTEGER RANGE 0 TO 1800000;
	-- SIGNAL unidades, decenas, centenas : INTEGER RANGE 0 TO 9;
	-- SIGNAL mul : INTEGER RANGE 0 TO 60000;
	-- SIGNAL bandera : INTEGER RANGE 0 TO 3;
	--signal bandera: std_logic;
	SIGNAL orden, orden2, orden3 : INTEGER RANGE 0 TO 2;
	SIGNAL PushA, PushB, PushC, Inicio : STD_LOGIC;
	SIGNAL retraso : INTEGER RANGE 0 TO 60000000;

BEGIN
	PushA <= NOT In1;
	PushB <= NOT In2;
	PushC <= NOT In3;
	Inicio <= NOT In4;

	PROCESS (clk)
		--variable bandera: integer range 0 to 3;
	BEGIN

		IF rising_edge (clk) THEN

			IF (PushA = '1' AND PushB = '0' AND PushC = '0' AND Inicio = '1') THEN
				contador <= contador + 1;
				IF contador = 1800000 THEN
					orden <= 1;
					orden2 <= 0;
					orden3 <= 0;
					contador <= 0;
				END IF;
			END IF;

			IF (PushA = '1' AND PushB = '1' AND PushC = '0' AND Inicio = '1') THEN
				contador <= contador + 1;
				IF contador = 1800000 THEN
				   orden <= 0;
					orden2 <= 1;
					contador <= 0;
				END IF;
			END IF;

			IF (PushA = '1' AND PushB = '1' AND PushC = '1' AND Inicio = '1') THEN
				contador <= contador + 1;
				IF contador = 1800000 THEN
				 orden <= 0;
					orden2 <= 0;
					orden3 <= 1;
					contador <= 0;
				END IF;
			END IF;
			IF orden = 1 or orden2 = 1 or orden3 = 1 THEN
				retraso <= retraso + 1;
			END IF;

			IF orden = 2 or orden2 = 2 or orden3 = 2THEN
				retraso <= 0;
			END IF;

			IF retraso = 15000000 AND orden = 1 THEN
				Out1 <= '1';
				Out2 <= '0';
				Out3 <= '0';
				Out4 <= '0';
			END IF;

			IF retraso = 30000000 AND orden = 1 THEN
				Out1 <= '0';
				Out2 <= '0';
				Out3 <= '0';
				Out4 <= '0';
			END IF;

			IF retraso = 45000000 AND orden = 1 THEN
				Out1 <= '1';
				Out2 <= '0';
				Out3 <= '0';
				Out4 <= '0';
			END IF;
			IF retraso = 60000000 AND orden = 1 THEN
				Out1 <= '0';
				Out2 <= '0';
				Out3 <= '0';
				Out4 <= '0';
			END IF;




			IF retraso = 15000000 AND orden2 = 1 THEN
				Out1 <= '0';
				Out2 <= '1';
				Out3 <= '0';
				Out4 <= '0';
			END IF;

			IF retraso = 30000000 AND orden2 = 1 THEN
				Out1 <= '0';
				Out2 <= '0';
				Out3 <= '0';
				Out4 <= '0';
			END IF;

			IF retraso = 45000000 AND orden2 = 1 THEN
				Out1 <= '0';
				Out2 <= '1';
				Out3 <= '0';
				Out4 <= '0';
			END IF;
			IF retraso = 60000000 AND orden2 = 1 THEN
				Out1 <= '0';
				Out2 <= '0';
				Out3 <= '0';
				Out4 <= '0';
			END IF;



			IF retraso = 15000000 AND orden3 = 1 THEN
				Out1 <= '0';
				Out2 <= '0';
				Out3 <= '1';
				Out4 <= '0';
			END IF;

			IF retraso = 30000000 AND orden3 = 1 THEN
				Out1 <= '0';
				Out2 <= '0';
				Out3 <= '0';
				Out4 <= '0';
			END IF;

			IF retraso = 45000000 AND orden3 = 1 THEN
				Out1 <= '0';
				Out2 <= '0';
				Out3 <= '1';
				Out4 <= '0';
			END IF;
			IF retraso = 60000000 AND orden3 = 1 THEN
				Out1 <= '0';
				Out2 <= '0';
				Out3 <= '0';
				Out4 <= '0';
			END IF;

			IF retraso = 0 THEN
				Out1 <= '0';
				Out2 <= '0';
				Out3 <= '0';
				Out4 <= '0';
			END IF;

		END IF;

	END PROCESS;
END Behavioral;