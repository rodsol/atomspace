-- GSoC 2015 - Haskell bindings for OpenCog.
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE ExistentialQuantification  #-}
{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE Rank2Types                 #-}
{-# LANGUAGE AutoDeriveTypeable         #-}
{-# LANGUAGE ScopedTypeVariables        #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE TypeOperators              #-}
{-# LANGUAGE ConstraintKinds            #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}

-- | This Module defines the different Atom Types and some utils functions.
module OpenCog.AtomSpace.AtomType (
    AtomType(..)
  , Up(..)
  , Is(..)
  , fromAtomTypeRaw
  , toAtomTypeRaw
  ) where

import OpenCog.AtomSpace.Template       (declareAtomType)

-- Usage of Template Haskell to generate definitions of AtomType,
-- some util functions: fromAtomTypeRaw and toAtomTypeRaw,
-- and type families: Up and Is.
--
-- You can see the code generated by template haskell with -dump-splices:
--   stack build --ghc-options=-ddump-splices --extra-lib-dirs=/usr/local/lib/opencog
--
-- 'AtomType' kind groups all atom types.
-- data AtomType = AnchorT
--               | AtomT
--               | ConceptT
--               | ...
--
-- fromAtomTypeRaw :: String -> Maybe AtomType
-- fromAtomTypeRaw "PredicateNode" = Just PredicateT
-- fromAtomTypeRaw "AndLink"       = Just AndT
-- fromAtomTypeRaw ...
--
-- toAtomTypeRaw :: AtomType -> String
-- toAtomTypeRaw PredicateT = "PredicateNode"
-- toAtomTypeRaw AndT       = "AndLink"
-- toAtomTypeRaw ...
--
-- Is ConceptT ConceptT = True
-- Is ConceptT AtomT    = True
-- Is ConceptT NodeT    = True
-- Is ...
--
-- Up AtomT    = '[AtomT]
-- Up ConceptT = '[ConceptT, AtomT, NodeT]
-- Up ...
--
-- | 'AtomType' is automatically generated by Template Haskell
-- (based on: atom_types.script file)
-- First path is when you build it inside the AtomSpace Reop
-- Second path is for when you build it from Hackage
-- Atomspace has to be installed in this case.
declareAtomType "../../../atomspace/atom_types.script" "/usr/local/share/opencog/atom_types.script"
