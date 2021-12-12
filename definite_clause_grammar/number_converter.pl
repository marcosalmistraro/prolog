/* the following program parses a given sentence.
The sentence must indicate a number between 0 and 999 in English

example query: ?- sentence(Converted, [one, hundred, thirty, nine], []). */

sentence(Converted) --> number(Converted).
sentence(Converted) --> number(ConvertedD), number(ConvertedU),
                    {Converted is ConvertedD + ConvertedU}.
sentence(Converted) --> number(ConvertedH), [hundred],
                    {Converted is ConvertedH * 100}.
sentence(Converted) --> number(ConvertedH), [hundred], number(ConvertedD), number(ConvertedU),
                    {compute_hundreds(ConvertedH, ConvertedD, ConvertedU, Converted)}.
sentence(Converted) --> number(ConvertedH), [hundred], number(ConvertedDU),
                    {compute_hundreds(ConvertedH, ConvertedDU, Converted)}.

number(Converted) --> [TextNumber], 
{convert(TextNumber, Converted)}.

compute_hundreds(ConvertedH, ConvertedD, ConvertedU, Converted):-
    TmpH is ConvertedH * 100,
    TmpSum is TmpH + ConvertedD,
    Converted is TmpSum + ConvertedU.

compute_hundreds(ConvertedH, ConvertedDU, Converted):-
    TmpH is ConvertedH * 100,
    Converted is TmpH + ConvertedDU.
    
convert(TextNumber, Converted):-
    (TextNumber = zero, Converted = 0);
    (TextNumber = one, Converted = 1);
    (TextNumber = two, Converted = 2);
    (TextNumber = three, Converted = 3);
    (TextNumber = four, Converted = 4);
    (TextNumber = five, Converted = 5);
    (TextNumber = six, Converted = 6);
    (TextNumber = seven, Converted = 7);
    (TextNumber = eight, Converted = 8);
    (TextNumber = nine, Converted = 9);
    (TextNumber = ten, Converted = 10);
    (TextNumber = eleven, Converted = 11);
    (TextNumber = twelve, Converted = 12);
    (TextNumber = thirteen, Converted = 13);
    (TextNumber = fourteen, Converted = 14);
    (TextNumber = fifthteen, Converted = 15);
    (TextNumber = sixteen, Converted = 16);
    (TextNumber = seventeen, Converted = 17);
    (TextNumber = eighteen, Converted = 18);
    (TextNumber = nineteen, Converted = 19);
    (TextNumber = twenty, Converted = 20);
    (TextNumber = thirty, Converted = 30);
    (TextNumber = forty, Converted = 40);
    (TextNumber = fifty, Converted = 50);
    (TextNumber = sixty, Converted = 60);
    (TextNumber = seventy, Converted = 70);
    (TextNumber = eighty, Converted = 80);
    (TextNumber = ninety, Converted = 90).