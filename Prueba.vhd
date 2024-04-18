LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Contador IS

	PORT (
		clk : IN STD_LOGIC;
		--pwm: out std_logic;
		In1 : IN STD_LOGIC;
		Out1, Out2, Out3 : OUT STD_LOGIC;
		In2 : IN STD_LOGIC
	);
END Contador;
ARCHITECTURE Behavioral OF Contador IS

	SIGNAL numero : INTEGER RANGE 0 TO 9;
	SIGNAL contador : INTEGER RANGE 0 TO 1800000;
	-- SIGNAL unidades, decenas, centenas : INTEGER RANGE 0 TO 9;
	-- SIGNAL mul : INTEGER RANGE 0 TO 60000;
	-- SIGNAL bandera : INTEGER RANGE 0 TO 3;
	--signal bandera: std_logic;
	SIGNAL orden : INTEGER RANGE 0 TO 2;
	SIGNAL PushA, PushB : STD_LOGIC;
	SIGNAL retraso : integer RANGE 0 TO 45000000;

BEGIN
	PushA <= NOT In1;
	PushB <= NOT In2;
	PROCESS (clk)
		--variable bandera: integer range 0 to 3;
	BEGIN

		IF rising_edge (clk) THEN

			IF (PushA = '1') THEN
				contador <= contador + 1;
				IF contador = 1800000 THEN
					orden <= 1;
					contador <= 0;
				END IF;
			END IF;

			IF (PushB = '1') THEN
				contador <= contador + 1;
				IF contador = 1800000 THEN
					orden <= orden - 1;
					contador <= 0;
				END IF;
			END IF;

			IF orden = 1 THEN
				retraso <= retraso + 1;
			END IF;

			IF orden = 2 THEN
				retraso <= 0;
			END IF;

			IF retraso = 15000000 THEN
				Out1 <= '1';
				Out2 <= '0';
				Out3 <= '0';
			END IF;

			IF retraso = 30000000 THEN
				Out1 <= '0';
				Out2 <= '1';
				Out3 <= '0';
			END IF;

			IF retraso = 45000000 THEN
				Out1 <= '0';
				Out2 <= '0';
				Out3 <= '1';
			END IF;
			IF retraso = 0 THEN
				Out1 <= '0';
				Out2 <= '0';
				Out3 <= '0';
			END IF;

		END IF;

	END PROCESS;
END Behavioral;