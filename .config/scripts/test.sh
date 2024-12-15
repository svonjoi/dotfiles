#!/bin/bash

busctl --user call \
  io.crow_translate.CrowTranslate \
  /io/crow_translate/CrowTranslate/MainWindow \
  io.crow_translate.CrowTranslate.MainWindow \
  translateSelection
