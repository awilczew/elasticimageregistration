/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: transformallpoints.h
 *
 * MATLAB Coder version            : 3.2
 * C/C++ source code generated on  : 05-Oct-2017 15:03:56
 */

#ifndef TRANSFORMALLPOINTS_H
#define TRANSFORMALLPOINTS_H

/* Include Files */
#include <math.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
//#include "rtwtypes.h"
// #include "transformallpoints_types.h"

/* Function Declarations */
extern void transformallpoints(double *nodes, int
  n, int m,unsigned int itmax,  double *x2, double *y2,
  double* xo, double* yo, double *x,double *y,int xsize, int ysize);

extern void my_interp(double *x_data, double *y_data, double *x_query,
        double *y_query, int mono,int imax,int jmax);

void my_reshape_2d(double *in, double **out,int sizey,int sizex);


#endif

/*
 * File trailer for transformallpoints.h
 *
 * [EOF]
 */
