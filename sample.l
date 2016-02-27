%option noyywrap
%option c++

%{
	enum yyTokens
	{	SUBJECT,
		VERB,
		NOUN,
		ADJECTIVE,
		PREPOSITION,
		ADVERBE,
		AUXILLIARIE_VERB,
		QUIT,
		HEX,
		NUMBER,
		WORD,
		WHITESPACE,
		UNKNOWN,
		OPERATION
	};
	
	class Scanner : public yyFlexLexer
	{
	//Functions Defined
		public:
			int			CreateStringBuffer(std::string SampleText);
			int			WordCount();
			void		yy_switch_to_buffer(struct yy_buffer_state* new_buffer);
			struct yy_buffer_state*
						yy_create_buffer(FLEX_STD istream* s, int size);
			void		yy_delete_buffer(struct yy_buffer_state* b);
			void		yyrestart(FLEX_STD istream* s);
			int			yylex();
			void		switch_streams(FLEX_STD istream* new_in,FLEX_STD ostream* new_out);

		private:
			int			yyState;
			std::string	strStateDescription;
			long		yyint;
			std::string	yyStateDescription;
			yyTokens	yyEnumState;

		public:
			void		SetState(int pState);
			int			SetDescription(std::string pDesc);
			std::string	GetDescription();
			int			GetState();
	};

	Scanner p;

	//name Scanner
	//Run command [win_flex p7.l]
	#define IOSTREAM
	using namespace std;

%}

HEX  	 0x[A-Fa-f0-9]+
WORDS    [A-z]+
NUMBERS  [0-9]+
_QUIT	 [Qq]?
WHITESPACE     [\t\n\s]+
OPERATION [=+-/*()]?

%%

"$S" 		{
				p.SetDescription("SUBJECT");
				p.SetState(SUBJECT);
				return p.GetState();
			}

"$N" 		{
				p.SetDescription("NON");
				p.SetState(NOUN);
				return p.GetState();
			}

"$V" 		{
				p.SetDescription("VERBE");
				p.SetState(VERB);
				return p.GetState();
			}

"$A" 		{
				p.SetDescription("AUXILLIARIE VERBE");
				p.SetState(AUXILLIARIE_VERB);
				return p.GetState();
			}

"$J" 		{
				p.SetDescription("ADJECTIVIF");
				p.SetState(ADJECTIVE);
				return p.GetState();
			}

"$D" 		{
				p.SetDescription("ADVERBE");
				p.SetState(ADVERBE);
				return p.GetState();
			}

"$P" 		{
				p.SetDescription("PREPOSITION");
				p.SetState(PREPOSITION);
				return p.GetState();
			}

"$Q"		{
				p.SetDescription("QUIT");
				p.SetState(QUIT);
				return  p.GetState();
			}

"$q"		{
				p.SetDescription("QUIT");
				p.SetState(QUIT);
				return  p.GetState();
			}

{WORDS}     {
				p.SetDescription("PAROLE");
				p.SetState(WORD);
				return p.GetState();
		    }

{NUMBERS}   {
				p.SetDescription("NUMÉRO");
				p.SetState(NUMBER);
				return p.GetState();
		    }

{HEX}		{
				p.SetDescription("HEX");
				p.SetState(HEX);
				return p.GetState();
			}

{OPERATION} {
				p.SetDescription("OPERATION");
				p.SetState(OPERATION);
				return p.GetState();
			}

{WHITESPACE} {
				p.SetDescription("");
				p.SetState(WHITESPACE);
				/*Do nothing*/ 
				return p.GetState();
			}

.			{
				p.SetDescription("UNKNOWN");
				p.SetState(UNKNOWN);
				return p.GetState();
			}

%%

string Scanner::GetDescription()
{
	return yyStateDescription;
}

int Scanner::GetState()
{
	return (int)yyEnumState;
}

int	Scanner::CreateStringBuffer(string SampleText)
{

	return 0;
}

int	Scanner::WordCount()
{
	return 0;
}

void Scanner::yy_switch_to_buffer(struct yy_buffer_state* new_buffer)
{
	yyFlexLexer::yy_switch_to_buffer(new_buffer);
}

struct yy_buffer_state*
	Scanner::yy_create_buffer(FLEX_STD istream* s, int size)
{
	return yyFlexLexer::yy_create_buffer(s, size);
}

void Scanner::yy_delete_buffer(struct yy_buffer_state* b)
{
	yyFlexLexer::yy_delete_buffer(b);
}

void Scanner::yyrestart(FLEX_STD istream* s)
{
	yyFlexLexer::yyrestart(s);
}

int	Scanner::yylex()
{
	return yyFlexLexer::yylex();
}

void Scanner::switch_streams(FLEX_STD istream* new_in,	FLEX_STD ostream* new_out)
{
	yyFlexLexer::switch_streams(new_in, new_out);
}

void Scanner::SetState(int pState)
{
	yyEnumState = (yyTokens)pState;
}

int Scanner::SetDescription(string pDesc)
{
	yyStateDescription = pDesc;
	return (int)size_t(yyStateDescription.c_str());
}

/*
This will be changed to a header file
int main(int argc, char **argv)
{
	int tok;
	//yyFlexLexer Scanner;
	
	while(tok = p.yylex()) 
	{
		cout << p.YYText() << " " << p.GetDescription().c_str() << " "<< p.YYLeng() << endl;
	}

	return 0;
}

*/