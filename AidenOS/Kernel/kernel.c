int kernel_main() 
{
    __int8 key = 0;

    if(key == 0)
    {
        __int16 j = 5;
        int* ptr = &j;
        int x = *ptr + 5;
        if(x > 5)
        {
            if(x > 7)
            {
                if(x == 10)
                {
                    int i = 15;
                    int* ptr2x = &x;
                    *ptr2x = i;
                    if(*ptr2x < 20)
                    {
                        if(*ptr2x == 15)
                        {
                            print("Worked!");
                        }
                    }
                }
            }
        }
    }
    if(key == 1)
    {
        print("Not Possible!");
    }
}