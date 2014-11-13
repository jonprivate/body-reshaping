/*hello.c*/
#include "mex.h" 
#include <string>
#include "SLIC.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) 
{   
    int width(0), height(0);
   // unsigned int (32 bits) to hold a pixel in ARGB format as follows:
   // from left to right,
   // the first 8 bits are for the alpha channel (and are ignored)
   // the next 8 bits are for the red channel
   // the next 8 bits are for the green channel
   // the last 8 bits are for the blue channel
    
    int i,j,sz, k;
    unsigned int* pbuff=NULL;
    unsigned int* Isp;
    double m = 20;
    int* Ilabel;
    //----get input parameters ----//
       pbuff=(unsigned int *) mxGetPr(prhs[0]); 
       height=mxGetScalar(prhs[1]); 
       width=mxGetScalar(prhs[2]);
       k=mxGetScalar(prhs[3]);
       m=mxGetScalar(prhs[4]); //Compactness factor. use a value ranging from 10 to 40 depending on your needs. Default is 10
       sz=height*width;
           
   //--------- set out put space -----//
    // important!//
   plhs[0]=mxCreateNumericMatrix(1,sz,mxUINT32_CLASS,mxREAL);  
   Isp= (unsigned int*) mxGetData(plhs[0]);

   plhs[1]=mxCreateNumericMatrix(1,sz,mxINT32_CLASS,mxREAL);  
   Ilabel=(int*) mxGetData(plhs[1]);
       //----------------------------------
       // Initialize parameters
       //----------------------------------
      
       int* klabels = new int[sz];
       int numlabels(0);
       //----------------------------------
       //Perform SLIC on the image buffer
      // ----------------------------------
       SLIC segment;
       segment.PerformSLICO_ForGivenK(pbuff, width, height, klabels, numlabels, k, m);

       //Draw boundaries around segments
      // ----------------------------------
      segment.DrawContoursAroundSegments(pbuff, klabels, width, height, 0xff0000);
      
    
      for(i=0;i<sz;i++)
      {    Isp[i]= pbuff[i];
           Ilabel[i]= klabels[i];
          // mexPrintf("%d\n",klabels[i]);
      }

} 



